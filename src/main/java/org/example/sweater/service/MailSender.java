package org.example.sweater.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailSender {

    @Value("${spring.mail.username}")
    private String username;

    @Autowired
    private JavaMailSender mailSender;

    public void send(String emailTo, String subject, String text) {
        var message = new SimpleMailMessage();

        message.setFrom(username);
        message.setTo(emailTo);
        message.setSubject(subject);
        message.setText(text);

        mailSender.send(message);
    }
}
