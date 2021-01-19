package org.example.sweater.service;

import org.example.sweater.domain.Role;
import org.example.sweater.domain.User;
import org.example.sweater.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Collections;
import java.util.StringJoiner;
import java.util.UUID;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MailSender mailSender;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username);
    }

    public boolean addUser(User user) {
        var existingUser = userRepository.findByUsername(user.getUsername());

        if (existingUser != null)
            return false;

        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());

        userRepository.save(user);

        if (!StringUtils.isEmpty(user.getEmail()))
            mailSender.send(
                    user.getEmail(),
                    "Activation code",
                    new StringJoiner("\n")
                            .add(String.format("Hello, %s!", user.getUsername()))
                            .add("Welcome to Sweater.")
                            .add(
                                    String.format(
                                            "Please, visit next link: " +
                                                    "http://localhost:8080/activate/%s",
                                            user.getActivationCode()
                                    )
                            )
                            .toString()
            );

        return true;
    }

    public boolean activateUser(String code) {
        var user = userRepository.findByActivationCode(code);

        if (user == null)
            return false;

        user.setActivationCode(null);

        userRepository.save(user);

        return true;
    }
}
