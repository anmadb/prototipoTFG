package com.gotrip.Go_Trip.DTO;

public class LoginRequest {
    private String username;
    private String email;
    private String password;

    // Add getters and setters
    public String getUsernameOrEmail() {
        return username != null && !username.isEmpty() ? username : email;
    }

    public String getPassword() {
        return password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
