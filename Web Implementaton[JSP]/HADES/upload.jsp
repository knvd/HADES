<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<%
if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
<script language="javascript">
	alert("You need to Login first!");
	</script>
<jsp:include page="loginpage.jsp" />
<%
}

else
{

	if ((session.getAttribute("flg") == null) || (session.getAttribute("flg") == "")) {
	out.println("<h2><b>Session Expired!</b></h2>");
	response.setHeader("Refresh", "1;url=home.jsp");
	}

	else
	{

	String flag =(String)session.getAttribute("flg");
	  File file ;
	   String filename="";
	   int maxFileSize = 150*1024*1024;	//set to 150 MB
	   int maxMemSize = 150*1024*1024;
	   String Dir = request.getRealPath("/users/");
	File fdir = new File(Dir);
	if(!fdir.exists())
		fdir.mkdir();
	   String filePath = Dir+"/"+session.getAttribute("userid")+"/";
	   session.setAttribute("dirname", filePath);
	   String contentType = request.getContentType();
	   if ((contentType.indexOf("multipart/form-data") >= 0)) {

	      DiskFileItemFactory factory = new DiskFileItemFactory();
	      factory.setSizeThreshold(maxMemSize);
		File tempdir = new File(filePath+"/TempFiles");
		if(!tempdir.exists())
			tempdir.mkdir();
	      factory.setRepository(new File(filePath+"/TempFiles"));
	      ServletFileUpload upload = new ServletFileUpload(factory);
	      upload.setSizeMax( maxFileSize );
	      try{ 
		 List fileItems = upload.parseRequest(request);
		 Iterator i = fileItems.iterator();
		 out.println("<html>");
		 out.println("<body>");
		 while ( i.hasNext () ) 
		 {
		    FileItem fi = (FileItem)i.next();
		    if ( !fi.isFormField () )  
		    {
		        String fieldName = fi.getFieldName();
		        String fileName = fi.getName();
			
		        boolean isInMemory = fi.isInMemory();
		        long sizeInBytes = fi.getSize();
			 
				if(flag.equals("enc"))			//if Encryption upload
				{
					filePath=filePath+"/ToEncrypt/";
					File encdir = new File(filePath);	
					if(!encdir.exists())
						encdir.mkdir();
					file = new File( filePath + fileName) ;	
					fi.write( file );
					 session.setAttribute("dirname", filePath);
					session.setAttribute("fname", fileName);
				 	response.sendRedirect("Edetails.jsp");	
				}
				else if(flag.equals("dec"))		//Decryption upload
				{
					filePath=filePath+"/ToDecrypt/";
					File decdir = new File(filePath);	
					if(!decdir.exists())
						decdir.mkdir();
					if(!fileName.contains(".hades")){%>
					<script>alert("Oops! Looks You Just Lost it! Encrypted File will have .hades extension eg. 'abc.hades'");</script>
					<%response.setHeader("Refresh", "0.1;url=decUpld.jsp");}
					else{					
					file = new File( filePath + fileName) ;	
					fi.write( file ) ;
					 session.setAttribute("dirname", filePath);
					session.setAttribute("fname", fileName);		 	
					response.sendRedirect("Ddetails.jsp");
					}
				 }
				else
				{
				out.println("Session Expired! try again..");
				response.setHeader("Refresh", "1;url=home.jsp");
				}
			

		     } 	//close if


		 }	//close while
		 out.println("</body>");
		 out.println("</html>");
	      }catch(Exception ex) {
		 out.println(ex);
		response.setHeader("Refresh", "1;url=home.jsp");
	      }
	   }else{
%>
<jsp:include page="header.jsp" />
<%
	      out.println("<html>");
	      out.println("<body>");
	      out.println("<p>File Upload Failed!</p>"); 
	      out.println("</body>");
	      out.println("</html>");
%>
<jsp:include page="footer.jsp" />
<%
	   }

	session.setAttribute("flg", null);
	}// 2nd else
}//Ist else
%>
