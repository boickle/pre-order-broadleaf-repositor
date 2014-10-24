package com.mycompany.pops.configuration;

import java.util.Arrays;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfiguration {
	
	
	@Value("${primary_nav}")
	private Integer primaryNav;
	public Integer primaryNav() { return primaryNav; } 
	
	@Value("${email_server_host}")
	private String emailServerHost;
	public String emailServerHost() { return emailServerHost; }
	
	@Value("${email_bcc_list}")
	private String[] emailBccList;
	public String[] emailBccList() { 
	
		return emailBccList; 
	}
	
}
