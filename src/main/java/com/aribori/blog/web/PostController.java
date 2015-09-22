package com.aribori.blog.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aribori.blog.domain.Post;
import com.aribori.blog.service.PostService;
import com.aribori.common.lib.ListContainer;

@Controller
public class PostController {
	
	@Autowired
	private PostService postService;
	

	@RequestMapping(value="/post/{id}", method=RequestMethod.GET)
	public String getPost(@PathVariable String id, Model model,
			@CookieValue(value = "getPostLog", required = false) Cookie cookie, 
			HttpServletResponse response) {
		if (id != null) {
			try {
				int postId = Integer.parseInt(id);
				model.addAttribute("post", postService.getPost(postId, cookie, response));
			} catch (NumberFormatException e) {
				return "redirect:/";
			}
		}
		return "blog/post";
	}
	
	@RequestMapping(value="/posts/{page}" )
	public String getPosts(@PathVariable String page, Model model) {
		if(page == null)
			model.addAttribute("listContainer", postService.getPosts(1));
		else
			model.addAttribute("listContainer", postService.getPosts(Integer.parseInt(page)));
		return "redirect:/";
	}
	
	@RequestMapping(value="/post", method=RequestMethod.POST)
	public String insertPost(Post post) {
		//TODO 회원/관리자 구현 후에 이 라인 수정해야함
		post.setWriter("아리보리");
		postService.insertPost(post);
		return "redirect:/";
	}
	
	@RequestMapping(value="/post", method=RequestMethod.PUT)
	public String updatePost(Post post) {
		postService.updatePost(post);
		return "redirect:/";
	}
	
	@RequestMapping(value="/post/{id}", method=RequestMethod.DELETE)
	public String deletePost(@PathVariable String id) {
		if (id != null) {
			int postId = Integer.parseInt(id);
			postService.deletePost(postId);
		}
		return "redirect:/";
	}
	
	@RequestMapping(value="/post/write", method=RequestMethod.POST)
	public String getWriteForm() {
		return "blog/write";
	}
	
	@RequestMapping(value="/post/update", method=RequestMethod.PUT)
	public String getUpdateForm(int postId, Model model) {
		model.addAttribute("post", postService.getPostNoHits(postId));
		return "blog/update";
	}
}
