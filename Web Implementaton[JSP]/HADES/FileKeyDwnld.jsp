
<%
    if ((session.getAttribute("Efname") == null) || (session.getAttribute("fname") == "")) {
	%>
<script language="javascript">

alert("Session Expired!");

</script>
<% 	out.println("<p><b><h2>Session Expired! Page will auto refresh</h2></b><p>");
	response.setHeader("Refresh", "1;url=encUpld.jsp");
}
else{


	String buttonvalue =request.getParameter("Dbutton");

	if(buttonvalue.equals("Efile"))
	{
	String EFname=(String)session.getAttribute("Efname");
	String EDirname=(String)session.getAttribute("Edirname");
	session.setAttribute("fname",EFname);
	session.setAttribute("dirname",EDirname);

	//response.setHeader("Refresh", "3;url=DownloadServlet.jsp");
	response.sendRedirect("DownloadServlet.jsp");
	}
	else
	{

	String KFname=(String)session.getAttribute("Kfname");
	String KDirname=(String)session.getAttribute("Kdirname");
	session.setAttribute("fname",KFname);
	session.setAttribute("dirname",KDirname);
	//response.setHeader("Refresh", "3;url=DownloadServlet.jsp");
	response.sendRedirect("DownloadServlet.jsp");
	}
}

%>
