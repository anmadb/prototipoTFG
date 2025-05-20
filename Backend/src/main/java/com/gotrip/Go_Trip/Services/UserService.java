package com.gotrip.Go_Trip.Services;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.gotrip.Go_Trip.Entities.User;
import com.gotrip.Go_Trip.Repositories.UserRepository;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public User registerUser(User user){ // este metodo hace todo el trabajo cuando un usuario se registra, recibe los datos del usuario

        if(userRepository.existsByUsername(user.getUsername())){
            throw new RuntimeException("El nombre de usuario ya existe.");
        }

        if(userRepository.existsByEmail(user.getEmail())){
            throw new RuntimeException("El email ya esta asociado a una cuenta.");
        }

        user.setPassword((passwordEncoder.encode(user.getPassword()))); //encripta la contraseña
        user.setCreatedAt(LocalDate.now());

        return userRepository.save(user);


    }

    public User login(String usernameOrEmail , String password) {

        Optional<User> userOptional = userRepository.findByUsername(usernameOrEmail);

        if (userOptional.isEmpty()) {
            userOptional = userRepository.findByEmail(usernameOrEmail);
        }

        User user = userOptional.orElseThrow(() ->
            new RuntimeException("Usuario o email no encontrado.")
        );

        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("Contraseña incorrecta.");
        }

        return user;
    }

    public Map<String, String> getUserProfile(Long id) {
        User userProfile = userRepository.getUserProfile(id);

        Map<String, String> response = new HashMap<>();
        response.put("username", userProfile.getUsername());
        response.put("avatar", userProfile.getAvatar());
        response.put("bio", userProfile.getBio());
        response.put("createdAt", userProfile.getCreatedAt().toString());


        return response;
    }

    public void deleteUserByUsername(String username) {
    User user = userRepository.findByUsername(username)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
    userRepository.delete(user);
    }

}
