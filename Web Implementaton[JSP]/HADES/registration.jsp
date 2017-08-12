<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="hadesED.*"%>

<%
if ((request.getParameter("uname") == null) || (request.getParameter("uname") == "")) {%>
<jsp:include page="header.jsp" />
<script language="javascript">
	alert("Fill up the details first!");
	</script>
<% out.println("<h2><b>Please fill up the details first!</b></h2>");%>
<jsp:include page="footer.jsp" />
<%
response.setHeader("Refresh", "1;url=reg.jsp");
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

//if tables do not exist
dobj.insert("CREATE TABLE IF NOT EXISTS members (id int(10) unsigned NOT NULL PRIMARY KEY auto_increment, first_name varchar(45) NOT NULL, email varchar(45) NOT NULL, uname varchar(45) NOT NULL,pass varchar(45) NOT NULL,regdate DATE  NOT NULL,e varchar(2500) NOT NULL DEFAULT 0,d varchar(2500) NOT NULL DEFAULT 0,n varchar(2500) NOT NULL DEFAULT 0);");

if(dobj.count("select * from members where uname='"+user+"';")<=0)
{
	boolean ifins = dobj.insert("insert into members(first_name, email, uname, pass, regdate) values ('" + fname + "','" + email + "','" + user + "','" + pwd + "', CURDATE());");

    if (ifins) 
    {		//make user folder 
	String strProjectDir = request.getRealPath("/users/");
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
	response.setHeader("Refresh", "1;url=index.jsp");
    }
}
else
{%>
	<script language="javascript">
	alert("User Name <%=user%> already taken!");
	</script>

<%

	response.setHeader("Refresh", "0.1;url=reg.jsp"); 
     
}

}	//else block of ist if

%>
