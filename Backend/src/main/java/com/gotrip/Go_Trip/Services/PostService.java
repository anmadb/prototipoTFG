package com.gotrip.Go_Trip.Services;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gotrip.Go_Trip.Entities.Post;
import com.gotrip.Go_Trip.Repositories.PostRepository;

import jakarta.transaction.Transactional;


@Service
public class PostService {

    //* Methods injection
    @Autowired
    private PostRepository postRepository;

    //- Methods

    public List<Post> getPosts() {
        return postRepository.getPosts();
    }

    public Post getPostById(Long id) {
        return postRepository.getPostById(id);
    }


    @Transactional
    public Post addPost(Long userId, MultipartFile img, String description, double latitude, double longitude) throws IOException {

        String imgName = saveImage(img, userId); 
        
        Post post = new Post();
        post.setUserId(userId);
        post.setImg(imgName);
        post.setDescription(description);
        post.setLatitude(latitude);
        post.setLongitude(longitude);
        // Guardar la imagen y obtener su nombre
       // return postRepository.addPost(userId, imgName, description, latitude, longitude);
       return postRepository.save(post);
    }


   


    private String saveImage(MultipartFile img, Long userId) throws IOException {
        String imgName = userId + "_" + System.currentTimeMillis() + ".jpg"; // Genera un nombre único para la imagen
        String path = "src/main/resources/static/Img/Posts/" + imgName; // Ruta donde se guardará la imagen

        try (FileOutputStream fos = new FileOutputStream(path)) {
            fos.write(img.getBytes());
        }

        return imgName;
    }

    //TODO: addPost()
    //TODO: updatePost(id)
    //TODO: deletePost(id)

    //TODO: getImgName(id)

}
