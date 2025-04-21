package com.gotrip.Go_Trip.Controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gotrip.Go_Trip.DTO.LoginRequest;
import com.gotrip.Go_Trip.Entities.User;
import com.gotrip.Go_Trip.Services.UserService;

import lombok.RequiredArgsConstructor;

@RestController //le dice a spring esta clase es un controlador web que respond epeticiones HTTP con datos
@RequestMapping("/api/auth") //todas las rutas de esta clase empezaran asi
@CrossOrigin(origins = "*", allowCredentials = "false")
@RequiredArgsConstructor
public class UserController {


    private final UserService userService;


    
    /* El siguiente metodo recibe una peticion HTTP POST que llega a la ruta /api/auth/register
     * El RequestBody dice: el JSON lo convierto en un objeto User.
     * El ResponseEntity permite devolver una respuesta personalizada
     */
    @PostMapping("/register")
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

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        
        try {
            User user = userService.login(request.getUsernameOrEmail(), request.getPassword());
            return ResponseEntity.ok("¡Hola de nuevo viajer@: " + user.getUsername() + "!");

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        }
   
    }
    
}
