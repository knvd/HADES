<%@ page import ="java.io.FileInputStream" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>

<%
    
  String filename = (String)session.getAttribute("fname");	//"cvr.jpg";   FILE NAME WITH EXTENSION//
 
  String filepath =(String)session.getAttribute("dirname");	// "/home/knvd/Documents/";   
	//filepath=request.getRealPath(filepath);        // ABSOLUTE FILE PATH //  

  response.setContentType("text/html");
PrintWriter ot = response.getWriter();  
  response.setContentType("APPLICATION/OCTET-STREAM");
	 
  response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);  
            
  int i;   
  while ((i=fileInputStream.read()) != -1) {  
    ot.write(i);   
  }   
  fileInputStream.close(); 
ot.close();  
%>

<%-- USING INLINE STUFF --%>
<%-- response.setHeader("Content-Disposition","inline; filename=\"" + filename + "\""); --%>
