<%
if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) 
{%>
	<script language="javascript">
	alert("You are not Logged in!");
	</script>

<%
response.setHeader("Refresh", "0.1;url=loginpage.jsp");
}

else
{

session.setAttribute("userid", null);
session.invalidate();
//response.sendRedirect("index.jsp");
%>
<script language="javascript">
	alert("Successfully Logged off! ");
	</script>
<jsp:include page="index.jsp" />
<%
}
%>

