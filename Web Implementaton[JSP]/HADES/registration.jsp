<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="hadesED.*"%>

<%
if ((request.getParameter("uname") == null) || (request.getParameter("uname") == "")) {
out.println("<h2><b>Please fill up the details first!</b></h2>");
response.setHeader("Refresh", "2;url=index.jsp");
}

else
{
    String user = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String email = request.getParameter("email");
	database dobj=new database();
	if(!dobj.connect("localhost","HADES","root","toor"))
		out.println("\nError Connecting to Database");
if(dobj.count("select * from members where uname='"+user+"';")<=0)
{
	boolean ifins = dobj.insert("insert into members(first_name, email, uname, pass, regdate) values ('" + fname + "','" + email + "','" + user + "','" + pwd + "', CURDATE());");

    if (ifins) 
    {
	 
	String strProjectDir = ""; 
	strProjectDir = request.getRealPath("/users/");
	File ProjectDir = new File(strProjectDir); 
	if(!ProjectDir.exists()) 
		ProjectDir.mkdir(); 
	File usrdir = new File(strProjectDir+"/"+user);
	usrdir.mkdir();
        session.setAttribute("userid", user);

	RsaFunctionClass.e_dGen(user);	//Generate One Time Dyanamic Public Key for the User, just added to db.


        response.sendRedirect("home.jsp");
       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    } else {
        ///response.sendRedirect("index.jsp");
	out.println("\nError Inserting Data to Database...");
	response.setHeader("Refresh", "2;url=index.jsp");
    }
}
else
{
	out.println("\nUser "+user+" already exists in Database. Please "+"<a href='index.jsp'>Login</a>");
	response.setHeader("Refresh", "2;url=index.jsp");      
}

}	//else block of ist if

%>
