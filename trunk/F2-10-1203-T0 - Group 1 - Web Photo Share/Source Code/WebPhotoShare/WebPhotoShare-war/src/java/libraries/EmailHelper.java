/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package libraries;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Hung Nguyen
 */
public class EmailHelper {
    public String toEmail;
    public String fromEmail =   "f1203t0@gmail.com";
    public String message;
    public String subject;

    public String getToEmail() {
        return toEmail;
    }

    public void setToEmail(String toEmail) {
        this.toEmail = toEmail;
    }

    public String getFromEmail() {
        return fromEmail;
    }

    public void setFromEmail(String fromEmail) {
        this.fromEmail = fromEmail;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }
    
    final String username = "f1203t0@gmail.com";
    final String password = "pass123456789";
    private Session session;

    public EmailHelper() {
        Properties props = System.getProperties();
    
        // -- Attaching to default Session, or we could start a new one --        
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        
        session = Session.getInstance(props,new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
    }
    
    /*
     * Send email method
     */
    public boolean send(){
        try {
            
            MimeMessage messageObject = new MimeMessage(session);

            messageObject.setFrom(new InternetAddress( this.getFromEmail()) );
            messageObject.setRecipients(Message.RecipientType.TO,InternetAddress.parse( this.getToEmail() ));
            messageObject.setSubject( this.getSubject() );
            messageObject.setText( this.getMessage(), "utf-8", "html");
            Transport.send(messageObject);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    /**
     *
     * @param toEmail the value of toEmail
     * @param resetKey the value of resetKey
     * @param nonMember the value of nonMember
     */
    public void emailRecoveryPassword(String toEmail, String resetKey, boolean nonMember){
        this.setToEmail(toEmail);
        this.setSubject("Account Recovery - Web Photo Share");
        if(nonMember){
            this.setMessage("Someone requested an account recovery on Web Photo Share for "+toEmail+", but we don’t have an account on this site that matches this email address.<br>\n" +
"\n" +
"If you would like to create an account on Web Photo Share just visit our sign-up page:<br>\n" +
"http://www.webphotoshare.com/Register<br>\n" +
"<br>\n" +
"If you did not request this account recovery, just ignore this email. We'll keep your accounts safe.");
        }else{
            this.setMessage("Hello,<br>" +
"<br>" +
"You recently asked to reset your Web Photo Share password.<br>" +
"<a href=\"http://www.webphotoshare.com/ResetPassword?key="+resetKey+"\">Click here to change your password.</a><br>" +
"<br>" +
"Alternatively, you can enter the following password reset code:<br>" +
""+resetKey+"<br>"+
"<br>" +
"Web Photo Share");
        }
        send();
        
    }
    
    /**
     *
     * Reply User Feedback via email
     * 
     * @param toName the value of toName
     * @param toEmail the value of toEmail
     * @param toSubject the value of toSubject
     * @param date the value of date
     * @param reply the value of reply
     */
    public void replyFeedback(String toName, String toEmail, String toSubject, String date, String reply){
        this.setToEmail(toEmail);
        this.setSubject("Web Photo Share Feedback: " + toSubject);
        this.setMessage("Hello " + toName + "<br>"+
"After receiving your feedback on  Web Photo Share at " + date + "<br>" + 
"We have prepared the enclosed response. Please review it and feel free to contact us with any questions.<br>" + 
"<br><br>" + reply + "<br><br>" + 
"Ragard,<br>" + 
"The Web Photo Share Team");
        send();
    }
    
    public void emailUserStatus(String toName, String toEmail, boolean isApproved){
        String emailSubject =   "Web Photo Share: Account declined";
        String emailContent =   "Hello " + toName + "<br>" +
"<br>" +
"The administrator had been declined your account at Web Photo Share. We are sorry about inconvenience.<br>" +
"<br>" +
"Please feel free to contact us with any questions<br>" +
"<br>" +
"Ragard,<br>" +
"The Web Photo Share Team";
        if(isApproved){
            emailSubject    =   "Web Photo Share: Account approved";
            emailContent    =   "Hello " + toName + "<br>" +
"<br>" +
"The administrator had been approved your account at Web Photo Share.<br>" +
"<br>" +
"Please feel free to contact us with any questions<br>" +
"<br>" +
"Ragard,<br>" +
"The Web Photo Share Team";
        }
        this.setToEmail(toEmail);
        this.setSubject(emailSubject);
        this.setMessage(emailContent);
        send();
    }
    
    public void replyContact(String toName, String toSubject, String toEmail, String toMessage){
        String emailContent =   "Hello " + toName + "<br>" +
"<br>" +
"After receiving your contact on  Web Photo Share<br>" + 
"We have prepared the enclosed response. Please review it and feel free to contact us with any questions.<br>" + 
"<br><br>" + toMessage + "<br><br>" + 
"Ragard,<br>" + 
"The Web Photo Share Team";
        this.setToEmail(toEmail);
        this.setSubject("Re: "+toSubject);
        this.setMessage(emailContent);
        send();
    }
    
    /*
     * Send notification email to administrator
     * on registration completed
     * 
     * @param name String Registered name
     * @return null
     */
    public void registrationAdminEmail(final String name){
        
    }
}
