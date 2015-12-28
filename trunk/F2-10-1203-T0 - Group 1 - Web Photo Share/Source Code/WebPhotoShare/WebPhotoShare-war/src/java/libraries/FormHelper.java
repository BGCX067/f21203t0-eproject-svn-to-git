/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package libraries;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Hung Nguyen
 */
public class FormHelper {
    /**
     * Demonstrate checking for String that is not null, not empty, and not white
     * space only using standard Java classes.
     *
     * @param string String to be checked for not null, not empty, and not white
     *    space only.
     * @return {@code true} if provided String is not null, is not empty, and
     *    has at least one character that is not considered white space.
     */
    public static boolean isNotNull(final String string)
    {
       return string != null && !string.isEmpty() && !string.trim().isEmpty();
    }
    
    /*
     * Encrypt password
     * @param password String to be encrypted
     * @return encrypted password
     */
    public static String hashPassword(String password) {
        String hashword = null;
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(password.getBytes());
            BigInteger hash = new BigInteger(1, md5.digest());
            hashword = hash.toString(16);
        } catch (NoSuchAlgorithmException nsae) {
        // ignore
        }
        return hashword;
    }
    /*
     * Checking for string is valid email or not
     * 
     * @param email String to be checked for valid email
     * 
     * @return{@code true} if provied String is valid email
     */
    
    public static boolean checkEmail(String email) {
        Pattern pattern = Pattern.compile("^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");
        Matcher matcher = pattern.matcher(email);
        if (!matcher.find()) {
            return false;
        } else {
            return true;
        }
    }
    /*
     * stringDate
     */
    public static Date stringToSQLDate(String value){

        // *** note that it's "yyyy-MM-dd hh:mm:ss" not "yyyy-mm-dd hh:mm:ss"  
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsed = format.parse(value);
            java.sql.Date sql = new java.sql.Date(parsed.getTime());
            return sql;
        } catch (ParseException ex) {
            Logger.getLogger(FormHelper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
