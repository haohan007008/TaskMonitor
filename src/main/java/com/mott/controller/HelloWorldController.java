package com.mott.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mott.service.HelloWorldService;

@Controller
public class HelloWorldController {
	@Autowired
    private HelloWorldService helloWorldService;
	
	@RequestMapping("helloworld")
    public String getNewName(@RequestParam("userName") String userName, HttpServletRequest request){

           String newUserName = helloWorldService.getNewName(userName);
           System.out.println("newUserName : " + newUserName);
           request.setAttribute("newUserName", newUserName);

           return "helloworld";

    }
}	
