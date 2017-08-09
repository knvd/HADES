
<%
    if ((session.getAttribute("Efname") == null) || (session.getAttribute("Efname") == "")) {
	%>
<script language="javascript">

alert("Session Expired!");

</script>
<% 	
	response.setHeader("Refresh", "0.1;url=encUpld.jsp");
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
