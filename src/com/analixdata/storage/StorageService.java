package com.analixdata.storage;

/*import com.google.appengine.tools.cloudstorage.GcsFileOptions;
import com.google.appengine.tools.cloudstorage.GcsFilename;
import com.google.appengine.tools.cloudstorage.GcsOutputChannel;
import com.google.appengine.tools.cloudstorage.GcsService;
import com.google.appengine.tools.cloudstorage.GcsServiceFactory;
import com.google.appengine.tools.cloudstorage.RetryParams;

import java.io.*;
*/
public class StorageService {

//private static final String BUCKET_NAME = "analixdata";
/*
GcsOutputChannel outputChannel = null;
private OutputStream os = null;

public void init(String fileName, String mime) throws Exception {
	
	System.out.println("Entro init");
	
	GcsService gcsService = GcsServiceFactory.createGcsService(RetryParams.getDefaultInstance());
    GcsFilename filename = new GcsFilename("analixdata", fileName);
    
    GcsFileOptions options = new GcsFileOptions.Builder().acl("public-read").mimeType(mime).build();

    
    //Builder fileOptionsBuilder = new GcsFileOptions.Builder();
    //fileOptionsBuilder.acl("public_read").mimeType(mime);
    //.setBucket(BUCKET_NAME)
    //.setKey(fileName)
     // or "image/jpeg" for image files
    //GcsFileOptions fileOptions = fileOptionsBuilder.build();
    outputChannel = gcsService.createOrReplace(filename, options);
	
	
    
}

public void storeFile(byte[] b, int readSize) throws IOException{
	System.out.println("Entro storage");

			os.write(b, 0, readSize);
			System.out.println("Antes de flush");
			os.flush();
			System.out.println("Despues de flush");

    
    System.out.println("PAso stoage");
}

public void destroy() throws Exception {
    os.close();
    outputChannel.close();
}*/
}
