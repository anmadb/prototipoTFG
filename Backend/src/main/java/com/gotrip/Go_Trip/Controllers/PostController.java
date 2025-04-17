package com.gotrip.Go_Trip.Controllers;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.gotrip.Go_Trip.Entities.Post;
import com.gotrip.Go_Trip.Services.PostService;

@RestController
@RequestMapping("/api/posts")
public class PostController {

    //* Methods injection
    @Autowired
    private PostService postService;

    //- http://localhost:8080/api/posts

    @GetMapping
    public List<Post> getPosts() {
        return postService.getPosts();
    }

    //- http://localhost:8080/api/posts/{id}

    @GetMapping("/{id}")
    public Post getPostById(@PathVariable Long id) {
        return postService.getPostById(id);
    }

    @GetMapping(value = "/img/{imageName}", produces = MediaType.IMAGE_JPEG_VALUE)
    public ResponseEntity<Resource> getImage(@PathVariable String imageName) {
        Resource resource = new ClassPathResource("static/Img/Posts/" + imageName);

        if (!resource.exists()) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_JPEG) // Ajusta según el tipo de imagen
                .body(resource);
    }

    @PostMapping()
    public void addPost( //@RequestParam("userId") Long userId,
            @RequestParam("image") MultipartFile image,
            @RequestParam("description") String description,
            @RequestParam("latitude") float latitude,
            @RequestParam("longitude") float longitude) throws IOException {

        long userId = 1;

        postService.addPost(userId, image, description, latitude, longitude);

    }


    @DeleteMapping("/{id}")
    public void deletePost(@PathVariable Long id) {
        postService.deletePostsById(id);
    } 

    //DONE: GET     api/posts
    //TODO: POST    api/posts

    //DONE: GET     api/posts/{id}
    //TODO: PUT     api/posts/{id}
    //TODO: DELETE  api/posts/{id}

    //DONE: GET     api/posts/img/{id}

}
