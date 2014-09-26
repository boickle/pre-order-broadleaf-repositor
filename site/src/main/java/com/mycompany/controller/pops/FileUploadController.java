package com.mycompany.controller.pops;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadController {
 
	protected static final Log LOG = LogFactory.getLog(FileUploadController.class);
 
	
	 @RequestMapping(value = "/myform/uploadMyFile", method = RequestMethod.POST)

	    public String uploadMyFile(HttpServletRequest request,
	            @RequestParam("file") MultipartFile file) throws IOException {

		 	if (file!=null) {
	    	LOG.info("inside uploadFileHandler. file="+file.getName()+" "+file.getOriginalFilename());
		 	}
		 	else {
		 		LOG.info("inside uploadFileHandler. but file is null");
			 		
		 	}
		 	
		 	BufferedReader br = new BufferedReader(new InputStreamReader(file.getInputStream(), "UTF-8"));
		 	String line;
		 	while ((line = br.readLine()) != null) {
		 	   LOG.info("I saw: "+line);
		 	}
		 	br.close();

		 	// Copy file to server
/*		 	String name = file.getOriginalFilename();

	        if (!file.isEmpty()) {
	            try {
	                byte[] bytes = file.getBytes();
	 
	                // Creating the directory to store file
	                String rootPath = System.getProperty("catalina.home");
	                File dir = new File(rootPath + File.separator + "tmpFiles");
	                if (!dir.exists())
	                    dir.mkdirs();
	 
	                // Create the file on server
	                File serverFile = new File(dir.getAbsolutePath()
	                        + File.separator + name);
	                BufferedOutputStream stream = new BufferedOutputStream(
	                        new FileOutputStream(serverFile));
	                stream.write(bytes);
	                stream.close();
	 
	                LOG.info("Server File Location="
	                        + serverFile.getAbsolutePath());
	 
	                //return "You successfully uploaded file=" + name;
	            } catch (Exception e) {
	                return "You failed to upload " + name + " => " + e.getMessage();
	            }
	        }
*/	        
		 	return "myfolder/done";
	        
	    }    
   
}
