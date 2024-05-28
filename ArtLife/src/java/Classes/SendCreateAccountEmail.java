/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author chamal
 */
public class SendCreateAccountEmail {

    static config configFile = new config();

    public static void sendEmail(String email, String fName, String lName) {
        String to = email;
        String subject = "Welcome To Art Life";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.starttls.enable", "true");
        Session session = Session.getDefaultInstance(props);

        try {
            InternetAddress fromAddress = new InternetAddress(configFile.getEmail());
            InternetAddress toAddress = new InternetAddress(to);

            Message message = new MimeMessage(session);
            message.setFrom(fromAddress);
            message.setRecipient(Message.RecipientType.TO, toAddress);
            message.setSubject(subject);

            String sb = "<head>"
                    + "<style type=\"text/css\">"
                    + "  .heading1 { color: #000000;text-align:center; }"
                    + "  .p1 { color: #000000;text-align:center; }"
                    + "</style>"
                    + "</head>"
                    + "<h1 class=\"heading1\">" + "Hi " + fName + "," + "</h1>"
                    + "<p class=\"p1\">"
                    + "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget massa sit amet metus"
                    + "pellentesque commodo. Vivamus ut ligula et velit "
                    + "</p>";
            message.setContent(sb, "text/html; charset=utf-8");
            message.saveChanges();

            // Send the message to the recipient. You also need to specify the username and
            // password to authenticate to the mail server.
            Transport.send(message, configFile.getEmail(), configFile.getPassword());
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
