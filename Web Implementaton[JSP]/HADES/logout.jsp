<%
if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
out.println("<h2><b>You are Not Logged in! One Needs to be BORN first, in Order to commit a SUICIDE :)</b></h2>");
response.setHeader("Refresh", "2;url=index.jsp");
}

else
{

session.setAttribute("userid", null);
session.invalidate();
response.sendRedirect("index.jsp");
}
%>

