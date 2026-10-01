package vn.iotstar.filter;

import java.io.IOException;
import java.nio.CharBuffer;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.config.ObjectFactory;
import org.sitemesh.config.properties.PropertiesFilterConfigurator;
import org.sitemesh.config.xml.XmlFilterConfigurator;
import org.sitemesh.webapp.SiteMeshFilter;
import org.sitemesh.webapp.WebAppContext;
import org.sitemesh.webapp.contentfilter.ResponseMetaData;
import org.w3c.dom.Element;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(filterName = "sitemesh", urlPatterns = {"/*"})
public class MySiteMeshFilter_24110257 extends ConfigurableSiteMeshFilter {

    private FilterConfig filterConfig;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;

        // Bọc request để chuyển đổi forward -> include trong các Controller trên Tomcat 11
        HttpServletRequest wrappedRequest = new HttpServletRequestWrapper(req) {
            @Override
            public RequestDispatcher getRequestDispatcher(String path) {
                RequestDispatcher rd = super.getRequestDispatcher(path);
                if (rd == null) {
                    return null;
                }
                return new RequestDispatcher() {
                    @Override
                    public void forward(ServletRequest request, ServletResponse response)
                            throws ServletException, IOException {
                        rd.include(request, response);
                    }

                    @Override
                    public void include(ServletRequest request, ServletResponse response)
                            throws ServletException, IOException {
                        rd.include(request, response);
                    }
                };
            }
        };

        super.doFilter(wrappedRequest, servletResponse, filterChain);
    }

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.setDecoratorPrefix("");

        // Cấu hình decorator cho 2 vai trò: User (web) và Admin
        builder.addDecoratorPath("/admin/*", "/decorators/admin.jsp")
               .addDecoratorPath("/admin", "/decorators/admin.jsp")
               .addDecoratorPath("/home", "/decorators/web.jsp")
               .addDecoratorPath("/", "/decorators/web.jsp")
               .addDecoratorPath("/products", "/decorators/web.jsp")
               .addDecoratorPath("/products-by-seller", "/decorators/web.jsp")
               .addDecoratorPath("/product/*", "/decorators/web.jsp")
               .addDecoratorPath("/login", "/decorators/web.jsp")
               .addDecoratorPath("/register", "/decorators/web.jsp")
               .addDecoratorPath("/verify-otp", "/decorators/web.jsp")
               .addDecoratorPath("/seller/*", "/decorators/web.jsp")
               .addExcludedPath("/image")
               .addExcludedPath("/image/*")
               .addExcludedPath("/uploads/*")
               .addExcludedPath("/assets/*");
    }

    @Override
    protected Filter setup() throws ServletException {
        ObjectFactory objectFactory = getObjectFactory();
        SiteMeshFilterBuilder builder = new SiteMeshFilterBuilder();
        FilterConfig cfg = this.filterConfig;

        try {
            new PropertiesFilterConfigurator(objectFactory, getConfigProperties(cfg)).configureFilter(builder);
        } catch (Exception ignored) {
        }

        try {
            Element xml = loadConfigXml(cfg, getConfigFileName());
            if (xml != null) {
                new XmlFilterConfigurator(objectFactory, xml).configureFilter(builder);
            }
        } catch (Exception e) {
            System.err.println("[SiteMesh Warning] XML config not loaded: " + e.getMessage());
        }

        applyCustomConfiguration(builder);

        final boolean includeErrors = builder.isIncludeErrorPages();

        return new SiteMeshFilter(builder.getSelector(), builder.getContentProcessor(),
                builder.getDecoratorSelector(), includeErrors) {

            @Override
            protected boolean postProcess(String contentType, CharBuffer buffer, HttpServletRequest request,
                    HttpServletResponse response, ResponseMetaData metaData) throws IOException, ServletException {
                boolean result = super.postProcess(contentType, buffer, request, response, metaData);
                try {
                    response.flushBuffer();
                } catch (Exception ignored) {
                }
                return result;
            }

            @Override
            protected WebAppContext createContext(String contentType, HttpServletRequest request,
                    HttpServletResponse response, ResponseMetaData metaData) {
                return new WebAppContext(contentType, request, response,
                        cfg.getServletContext(),
                        getContentProcessor(), metaData, includeErrors) {

                    @Override
                    protected void dispatch(HttpServletRequest req, HttpServletResponse res, String path)
                            throws ServletException, IOException {
                        String targetPath = path;
                        if (targetPath.contains("/WEB-INF/decorators/decorators/")) {
                            targetPath = targetPath.replace("/WEB-INF/decorators/decorators/", "/decorators/");
                        }

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(targetPath);
                        if (dispatcher == null) {
                            dispatcher = getServletContext().getRequestDispatcher("/decorators/web.jsp");
                        }

                        dispatcher.include(req, res);
                    }
                };
            }
        };
    }
}
