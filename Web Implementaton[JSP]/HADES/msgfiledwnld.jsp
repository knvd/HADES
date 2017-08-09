<%
String fboxname=request.getParameter("fboxname");
String dboxname=request.getParameter("dboxname");
String fname=request.getParameter(fboxname);
String dname=request.getParameter(dboxname); 
out.println(fname+dname);
session.setAttribute("fname",fname);
session.setAttribute("dirname",dname);
response.sendRedirect("DownloadServlet.jsp");

%>
