<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="video.Video"%>
<%@ page import="video.VideoDAO"%>
<%@ page import="java.util.ArrayList"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%
String userID = "";
userID = (String) session.getAttribute("userID"); 

%>




<aside id="sidebar">
	<div class="toggle-btn" onclick="toggleSidebar()">
		<span></span> <span></span> <span></span>
	</div>
	<ul class="lnb">
		<%
	VideoDAO videoDAO = new VideoDAO();
	ArrayList<Video> list = videoDAO.getList(userID);
	for(int i = 0; i < list.size(); i++){
	%>

		<li>
			<a href="javascript:fnShowVideo('<%=list.get(i).getVideoID()%>')">
			<img src="https://i.ytimg.com/vi/<%=list.get(i).getVideoID()%>/default.jpg"></a>
		</li>


	<%
		}
	%>

	</ul>
</aside>

<script src="vendor/jquery/common.js"></script>