/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import static Classes.sendUpdatePasswordEmail.configFile;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author chamal
 */
public class sendMessageEmail {

    static config configFile = new config();

    public static void sendEmail(String uName, String uEmail, String uSubject, String uMessage) throws Exception {

        String name = uName;
        String to = uEmail;
        String subject = uSubject;

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.starttls.enable", "true");
        Session session = Session.getDefaultInstance(props);

        InternetAddress fromAddress = new InternetAddress(to);
        InternetAddress toAddress = new InternetAddress(configFile.getEmail());

        Message message = new MimeMessage(session);
        message.setFrom(fromAddress);
        message.setRecipient(Message.RecipientType.TO, toAddress);
        message.setSubject(subject);

        String sb = "<head>"
                + "<style type=\"text/css\">"
                + "</style>"
                + "</head>"
                + "<h3>A message from " + name + "</h3>"
                + "<p>"
                + uMessage
                + "</p>";
        message.setContent(sb, "text/html; charset=utf-8");
        message.saveChanges();

            // Send the message to the recipient. You also need to specify the username and
        // password to authenticate to the mail server.
        Transport.send(message, configFile.getEmail(), configFile.getPassword());

    }

}
