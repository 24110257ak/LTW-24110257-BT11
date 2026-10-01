package vn.iotstar.util;

import java.util.Properties;
import java.util.Random;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil_24110257 {

    public static String generateOtp(int length) {
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }

    public static boolean sendOtpEmail(String toEmail, String otp, String purpose) {
        System.out.println("=================================================================");
        System.out.println("🔔 [HỆ THỐNG GỬI OTP] Email nhận: " + toEmail);
        System.out.println("🔔 Mục đích: " + purpose);
        System.out.println("🔑 MÃ OTP CỦA BẠN LÀ: ===> [ " + otp + " ] <===");
        System.out.println("=================================================================");

        String host = "smtp.gmail.com";
        String port = "587";
        final String fromEmail = "hcmute.testweb@gmail.com";
        final String password = "testpassword123";

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.connectiontimeout", "3000");
        props.put("mail.smtp.timeout", "3000");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail, "HCMUTE Exam Store"));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setSubject("[HCMUTE - 24110257] Mã OTP " + purpose + ": " + otp, "UTF-8");

            String htmlContent = "<div style=\"font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px;\">"
                    + "<h2 style=\"color: #0d6efd; text-align: center;\">XÁC THỰC TÀI KHOẢN - MSSV: 24110257</h2>"
                    + "<p>Xin chào,</p>"
                    + "<p>Bạn đã yêu cầu <strong>" + purpose + "</strong> trên hệ thống Web.</p>"
                    + "<p>Mã xác thực OTP của bạn là:</p>"
                    + "<div style=\"text-align: center; margin: 25px 0;\">"
                    + "  <span style=\"font-size: 32px; font-weight: bold; letter-spacing: 6px; color: #d63384; background: #f8f9fa; padding: 12px 24px; border-radius: 6px; border: 2px dashed #d63384;\">"
                    + otp + "</span>"
                    + "</div>"
                    + "<p style=\"color: #dc3545;\"><em>* Mã OTP có hiệu lực trong vòng 5 phút. Vui lòng không chia sẻ mã cho người khác.</em></p>"
                    + "<hr style=\"border: none; border-top: 1px solid #eee; margin: 20px 0;\" />"
                    + "<p style=\"font-size: 12px; color: #6c757d; text-align: center;\">Bài thi Quá trình - Đề 05 - MSSV: 24110257 - HCMUTE</p>"
                    + "</div>";

            msg.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(msg);
            System.out.println("✅ [EMAIL] Đã gửi thành công email chứa OTP tới: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("⚠️ [EMAIL LỖI] Không thể gửi qua SMTP Gmail (môi trường thi offline): " + e.getMessage());
            System.out.println("💡 Gợi ý: Hãy sử dụng mã OTP [ " + otp + " ] đã được in ra console ở trên để xác thực!");
            return false;
        }
    }
}
