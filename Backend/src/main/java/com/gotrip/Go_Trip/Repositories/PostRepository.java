package com.gotrip.Go_Trip.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.gotrip.Go_Trip.Entities.Post;

public interface PostRepository extends JpaRepository<Post,Long> {

    //- SQL's Queries

    @Query(value = "SELECT * FROM posts", nativeQuery = true)
    List<Post> getPosts();

    @Query(value = "SELECT * FROM posts WHERE id = :id", nativeQuery = true)
    Post getPostById(@Param("id") Long id);

   /*  @Modifying
    @Transactional
    @Query(value = "INSERT INTO posts (\"user-id\",\"img\",\"description\",\"latitude\",\"longitude\") values (':user-id',':img',':description',':latitude',':longitude');", nativeQuery = true)
    Post addPost(@Param("user-id") Long userId, @Param("img") String img, @Param("description") String description, @Param("latitude") double latitude, @Param("longitude") double longitude);
 */
    
    //TODO: addPost()
    //TODO: updatePost(id)
    //TODO: deletePost(id)

    //TODO: getImgName(id)

}
