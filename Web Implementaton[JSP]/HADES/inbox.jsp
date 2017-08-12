<%@ page import="hadesED.*"%>
<%@ page import ="java.sql.*" %>

<%
String uname= (String)session.getAttribute("userid");
if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) 
{ %>
			<jsp:include page="loginpage.jsp" />
<%} 
else 
{
String curUser= (String)session.getAttribute("userid");
database dobj=new database();

	ResultSet rs;
		
	try
	{
	if (!dobj.connect("localhost","HADES","root","toor"))
		out.println("Database Connection Refused!");

//if msg table doesnt exist create it
dobj.insert("CREATE TABLE IF NOT EXISTS messages (id int(10) unsigned NOT NULL PRIMARY KEY auto_increment, reciever varchar(45) NOT NULL, sender varchar(45) NOT NULL, subject varchar(200) NOT NULL,file varchar(250) NOT NULL, tfile varchar(250) NOT NULL,edir varchar(250) NOT NULL, txtdir varchar(250) NOT NULL);");

	int total=dobj.count("select * from messages where reciever='"+curUser+"';");

	String sender="",subject="";
	String [] file=new String[total];
	String [] tfile=new String[total];
	String [] edir=new String[total];
	String [] txtdir=new String[total];


	if(total>0)
		{%>
			<jsp:include page="header.jsp" />
			<div class="fullbody">
			<html>
			<head>
			 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title><%=curUser%>'s Inbox</title>
			<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
			</head>
			<body>

			<center>
			<div style=" margin-left: 100px;"> <a style="text-align: left; color: #ff3300; "><h2> <%=curUser%>'s Inbox</h2></a></div>
			
			<table style="width: 85%;">
			
			<thead align="center"><tr><td><a style="color: #02c2f7; font-size: 150%;"><u>#</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>FROM:</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Subject</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Files</u></a></td></tr></thead>
			<tr><td colspan="4"> <a target="_new" href="outbox.jsp" style="color: #ff3300; float: right;"><h2><u>MY OUTBOX</u></h2></a></td></tr>



		<%

			rs=dobj.select("select sender,subject,file,tfile,edir,txtdir from messages where reciever='"+curUser+"';");
			int sno=0;
			while(rs.next())
				{
				sender=rs.getString("sender");
				subject=rs.getString("subject");
				file[sno]=rs.getString("file");
				tfile[sno]=rs.getString("tfile");
				edir[sno]=rs.getString("edir");
				txtdir[sno]=rs.getString("txtdir");
				sno++;
				%>

			<tr align="center">
			<td style="font-size: 120%; color: #000000;"><%=sno%> </td><td style="font-size: 140%; color: #ff3300;;"><%=sender%> </td> <td><%=subject%></td>
<td>


<%String folder=txtdir[sno-1].toString();
folder=folder.substring(folder.indexOf("users"), folder.length());
//String dr=edir[sno-1].toString();
//dr=dr.substring(dr.indexOf("users"), dr.length());
//String fn=file[sno-1].toString();
%>
<a target="_new" href="<%=folder+tfile[sno-1].toString()%>"> View Key Details</a><br /><br />

<form action=msgfiledwnld.jsp method=post>
<input type="text" id="filebox" name="ftxt<%=sno%>"  value="<%=file[sno-1].toString()%>" readonly style="display: none;"/>
<input type="text" id="dirbox" name="dtxt<%=sno%>"  value="<%=edir[sno-1].toString()%>" readonly  style="display: none;"/>
<input type="text" name="fboxname"  value="ftxt<%=sno%>" readonly  style="display: none;"/>
<input type="text" name="dboxname"  value="dtxt<%=sno%>" readonly  style="display: none;"/>
<input type="submit" value="Download File" />
</form>
</td><br /> 
			</tr>
<%
				}//end of while				
%>
			</table>
			</center> 
			</body>
			</html>
		<jsp:include page="footer.jsp" />
<%
}//close if
else		//if(tot)
{%>
<script>
alert("<%=curUser%>'s Inbox is Empty");
</script>
<jsp:include page="header.jsp" />
<div class="fullbody">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=curUser%>'s Inbox is Empty</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>
<body>
<center>
<a style="text-align: left; color: #ff3300; "><h2> <%=curUser%>'s Inbox</h2></a>			
<table style="width: 80%;">
<thead align="center"><tr><td><a style="color: #02c2f7; font-size: 150%;"><u>FROM:</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Subject</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Files</u></a></td></tr></thead>
<tr><td colspan="3"><a target="_new" href="outbox.jsp" style="color: #ff3300; text-align: right;"><h2><u>MY OUTBOX</u></h2></a></td></tr>

<tr ><td colspan="3" align="center"><h2>No One has Messaged You Yet! <br /><a href="home.jsp"> Back To Home</a></h2></td> </tr>
</table>
</center> 
</body>
</html>
<jsp:include page="footer.jsp" />

<%}	//close else
}	//try block
catch(SQLException e1)
{
out.println(e1);
}


}
%>
