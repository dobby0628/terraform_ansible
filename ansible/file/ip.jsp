<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.net.InetAddress" %>


클라이언트 IP <%=request.getRemoteAddr()%><br>
요청URI <%=request.getRequestURI()%><br>
요청URL: <%=request.getRequestURL()%><br>
서버이름 <%=request.getServerName()%><br>
<%
InetAddress inet= InetAddress.getLocalHost();
%>
동작 서버 IP <%=inet.getHostAddress()%><br>
서버포트 <%=request.getServerPort()%><br>


