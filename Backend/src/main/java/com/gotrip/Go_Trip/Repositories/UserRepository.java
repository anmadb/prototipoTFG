package com.gotrip.Go_Trip.Repositories;

import com.gotrip.Go_Trip.Entities.User;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface UserRepository extends JpaRepository<User, Long>{ //Esta trabjando con la clase User y la clave primaria es de tipo Long


    Optional<User> findByUsername(String username);//busca usuarios por su nombre de usuario

    Optional<User> findByEmail(String email);//busca usuarios por su email

    boolean existsByUsername(String username);//verifica si ese usuario ya existe

    boolean existsByEmail(String email);  //verifica si ese usuario ya existe

    @Query(value = "SELECT * FROM gotrip_db.users WHERE id=:id", nativeQuery = true)
    User getUserProfile(@Param("id") Long id);
}