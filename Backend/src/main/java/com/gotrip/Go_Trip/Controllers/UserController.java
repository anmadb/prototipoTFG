package com.gotrip.Go_Trip.Controllers;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
/* import org.springframework.web.bind.annotation.CrossOrigin; */ // Unused. No se si funciona
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gotrip.Go_Trip.DTO.LoginRequest;
import com.gotrip.Go_Trip.Entities.User;
import com.gotrip.Go_Trip.Services.UserService;

import com.gotrip.Go_Trip.Utilities.JwtUtilities;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.security.SignatureException;
import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseCookie;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController //le dice a spring esta clase es un controlador web que respond epeticiones HTTP con datos
@RequestMapping("/api") //todas las rutas de esta clase empezaran asi
@RequiredArgsConstructor
public class UserController {


    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }


    
    /* El siguiente metodo recibe una peticion HTTP POST que llega a la ruta /api/auth/register
     * El RequestBody dice: el JSON lo convierto en un objeto User.
     * El ResponseEntity permite devolver una respuesta personalizada
     */
    @PostMapping("/auth/register")
    public ResponseEntity<?> register(@RequestBody User user){

        /* Si todo va bien llama a registerUser (UserService) y devuelve 200 OK con el usuariola clas
         * Si ocurre un error captura la excepción y devuelve 400 Bad Request conn el mensaje de error
         */
        try{
            User newUser = userService.registerUser(user);
            return ResponseEntity.ok(newUser);
        }catch(RuntimeException e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/auth/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        
        try {
            User user = userService.login(request.getUsernameOrEmail(), request.getPassword());

            JwtUtilities jwtUtilities = new JwtUtilities();

            String token = jwtUtilities.generateToken(user.getId().toString(), user.getUsername(), user.getEmail());

            ResponseCookie cookie = ResponseCookie.from("isLogged", token)
                .httpOnly(false)
                .secure(false)
                .path("/")
                .maxAge(24 * 60 * 60) // Seconds (24h)
                .sameSite("Lax")
                .build();

            return ResponseEntity.ok()
                        .header("Set-Cookie", cookie.toString())
                        .body("¡Hola de nuevo viajer@: " + user.getUsername() + "!");

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        }
   
    }
    
    @PostMapping("/auth/isLogged")
    public ResponseEntity<?> isLogged(@RequestBody String token) {
        
        JwtUtilities jwtUtilities = new JwtUtilities();
        try {

        // Parse the token to get the claims
        Map<String, Object> claims = jwtUtilities.parseToken(token);

        // Check if token is expired (parseToken would throw exception if expired,
        long expirationTime = ((Number) claims.get("exp")).longValue() * 1000;
        Date expirationDate = new Date(expirationTime);

        if (expirationDate.before(new Date())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token expired");
        }

        // Token is valid - return user information
        Map<String, String> response = new HashMap<>();
        response.put("res", "true");
        response.put("id", (String) claims.get("id"));
        response.put("username", (String) claims.get("username"));
        response.put("email", (String) claims.get("email"));
        

        return ResponseEntity.ok(response);
    } catch (Exception e) {
        Map<String, String> response = new HashMap<>();
        response.put("res", "false");
        response.put("message", "Invalid token" + e.getMessage());
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
    }
    }
    
    @GetMapping("/profile/{id}")
    public Map<String, String> getUserProfile(@PathVariable Long id) {

    Map<String, String> userProfile = userService.getUserProfile(id);
    return userProfile;
    }


    @DeleteMapping("/auth/delete-account")
public ResponseEntity<?> deleteAccount(@RequestHeader("Authorization") String authHeader) {
    try {
        // Valida el formato del header "Bearer token"
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token no proporcionado o formato inválido");
        }

        // Extrae el token (elimina "Bearer ")
        String token = authHeader.substring(7);
        
        // Usa tu JwtUtilities para validar y extraer el username
        JwtUtilities jwtUtilities = new JwtUtilities();
        String username = jwtUtilities.getUsernameFromToken(token);

        // Elimina el usuario
        userService.deleteUserByUsername(username);

        // Respuesta exitosa
        return ResponseEntity.ok().body("Cuenta eliminada correctamente");

    } catch (ExpiredJwtException e) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token expirado");
    } catch (SignatureException | MalformedJwtException e) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token inválido");
    } catch (RuntimeException e) {
        return ResponseEntity.badRequest().body(e.getMessage());
    } catch (Exception e) {
        return ResponseEntity.internalServerError().body("Error interno: " + e.getMessage());
    }
}
}