<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

	<head>
	 
		<jsp:include page="include/title.jsp" flush="false"/>
			<%
	          	String userID = null;
	    		if(session.getAttribute("userID") != null) {
	    			userID = (String) session.getAttribute("userID");
	    		}
          		if(userID != null){    	
          		
          	%>
			<jsp:include page="include/lnb.jsp" flush="false"/>
			<%
          		}
          	%>
          	
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
     <meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
     <!--  
          <style>
               p.box { border:1px solid #000; }
               /* Google Speech API */
               #speech_Button {
                    border: none;
                    background-color:transparent;
                    padding: none;
               }

               /* Mic 이미지 크기 */
               #speech_img {
                    width: 35px;
                    height: 35px;
               }
          </style>-->
	</head>
	
	<body>			
			<div class="conn">
			    <jsp:include page="include/header.jsp" flush="false"/> 
			    
			    <main>  	
					<div id ="view" style="text-align:center"></div>      				
       				<div id="get_view"></div>
					<div id="nav_view"></div>	 
				
		        </main>
		        <jsp:include page="include/footer.jsp" flush="false"/>
	        </div>
	</body>
	

</html>

