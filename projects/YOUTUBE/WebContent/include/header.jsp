<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.socket.io/socket.io-1.2.0.js"></script>
<script src="pv_porcupine.js"></script>
<script src="porcupine.js"></script>
<script src="picovoiceAudioManager.js"></script>
<script src="vendor/jquery/common.js"></script>

<h1 class="site-heading text-center text-white d-none d-lg-block">
	<a href="main.jsp"><span
		class="site-heading-upper text-primary mb-3">Youtube</span></a>
</h1>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light py-lg-4" id="mainNav">
	<div class="container">
		<a
			class="navbar-brand text-uppercase text-expanded font-weight-bold d-lg-none"
			href="#"></a>

		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav mx-auto">
				<li class="nav-item px-lg-4 sub00"><a
					class="nav-link text-uppercase text-expanded" href="main.jsp">Home
						<span class="sr-only">(current)</span>

				</a></li>
				<li class="nav-item px-lg-4 sub01"><a
					class="nav-link text-uppercase text-expanded"
					href="javascript:fnList(0);">Music</a></li>
				<li class="nav-item px-lg-4 sub02"><a
					class="nav-link text-uppercase text-expanded"
					href="javascript:fnList(1);">Sports</a></li>
				<li class="nav-item px-lg-4 sub03"><a
					class="nav-link text-uppercase text-expanded"
					href="javascript:fnList(2);">Movie</a></li>
				<li class="nav-item px-lg-4 sub04"><a
					class="nav-link text-uppercase text-expanded"
					href="javascript:fnList(3);">News</a></li>
				<li class="nav-item px-lg-4 sub05"><a
					class="nav-link text-uppercase text-expanded"
					href="javascript:fnList(4);">Games</a></li>
			</ul>

			<%
	          	String userID = null;
	    		if(session.getAttribute("userID") != null) {
	    			userID = (String) session.getAttribute("userID");
	    		}
          		if(userID == null){    	
          		
          	%>

			<ul class="navbar-nav navbar-right  mx-auto">
				<li class="nav-item px-lg-4 dropdown"><a href="#"
					class="nav-link text-uppercase text-expanded dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="nav-item px-lg-4  "><a
							class="nav-link text-uppercase text-expanded" href="login.jsp">로그인</a></li>
						<li class="nav-item px-lg-4 "><a
							class="nav-link text-uppercase text-expanded" href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
          		} else {
          	%>
			<ul class="navbar-nav navbar-right  mx-auto">
				<li class="nav-item px-lg-4 dropdown"><a href="#"
					class="nav-link text-uppercase text-expanded dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="nav-item px-lg-4 active"><a
							class="nav-link text-uppercase text-expanded"
							href="logoutAction.jsp">로그아웃</a></li>

					</ul></li>
			</ul>
			<%
          		}
          	%>
		</div>
	</div>

</nav>

<form name="form1" method="post" onSubmit="return false;" class="form1"
	id="form1">
	<input type="text" id="search_box" style="text-align: center" size="50"
		onkeydown="chkEnter()"><a href="javascript:fnList(5);"
		class="btn" id="btnenter">검색</a>
	<button id="demo_button" onclick="start()">
		<img id="start_img" src="./mic.gif" alt="Start Listening....">
	</button>
</form>

<script>

let keywordIDs = {
                'ok lamp': new Uint8Array([
                      0x02, 0xf3, 0x72, 0xe4, 0x71, 0x36, 0x29, 0x30, 0x1a, 0x67, 0xd3, 0x37,
                      0xb4, 0x29, 0x83, 0x52, 0x0b, 0x84, 0xb6, 0x25, 0xa2, 0xf3, 0x98, 0x66,
                      0xc5, 0x3c, 0x20, 0x20, 0xb7, 0xc0, 0x79, 0x4f, 0xd4, 0xbb, 0xa9, 0x77,
                      0x7b, 0xaa, 0x50, 0x6c, 0x99, 0x23, 0x5e, 0xb3, 0xe7, 0xfb, 0x80, 0x4a,
                      0xb3, 0xcc, 0x4f, 0x12, 0x16, 0x1e, 0x31, 0x5e, 0x9b, 0x03, 0x20, 0xbc,
                      0xf7, 0x08, 0xa2, 0xc4, 0xb1, 0xde, 0x8c, 0xfb, 0x9c, 0x64, 0xc7, 0x2c,
                      0x16, 0x52, 0xdb, 0xa0, 0x7e, 0xf4, 0x0d, 0x37, 0xbd, 0xd3, 0x3e, 0xac,
                      0x06, 0xa7, 0x16, 0xa7
                    ]),
                'yellow': new Uint8Array([
                      0xa8, 0xa9, 0x76, 0x41, 0xba, 0xb0, 0xf7, 0x02, 0x4e, 0xb1, 0xf9, 0x61,
                      0xcc, 0x4f, 0x72, 0x4d, 0x6c, 0xda, 0x55, 0x03, 0xcd, 0x47, 0xe7, 0xc0,
                      0x62, 0xdc, 0xdc, 0x68, 0x5a, 0x68, 0x05, 0x2b, 0x7c, 0x28, 0x61, 0x32,
                      0x3c, 0x5d, 0x3b, 0x26, 0x95, 0x72, 0x4c, 0x6f, 0x82, 0xf2, 0x13, 0xe4,
                      0x00, 0xd5, 0x6e, 0xb3, 0x6a, 0xea, 0x43, 0x31, 0xe2, 0x61, 0xce, 0x40,
                      0xf2, 0xf1, 0xe1, 0xa1, 0xa1, 0x89, 0xc9, 0xb0, 0x36, 0x27, 0xf6, 0xb5]),
                'orange': new Uint8Array([
                      0xd2, 0xe8, 0xe8, 0xbc, 0xee, 0x44, 0xd1, 0xc7, 0x8c, 0x96, 0x78, 0x04,
                      0x68, 0x4c, 0x21, 0x17, 0xd9, 0x2e, 0x8e, 0xd3, 0xa1, 0xf8, 0xad, 0x48,
                      0xd8, 0x3a, 0x52, 0x37, 0x0a, 0xc5, 0xe1, 0x5a, 0xa9, 0xc5, 0x73, 0xf9,
                      0x51, 0x7d, 0xc8, 0x6c, 0x5c, 0x70, 0x5f, 0xed, 0x0f, 0xbe, 0xea, 0x76,
                      0x11, 0x26, 0x4f, 0x5c, 0x04, 0xb4, 0x97, 0x3f, 0x9b, 0xec, 0xb1, 0x19,
                      0x19, 0xe6, 0xe3, 0x1e, 0x2b, 0xc0, 0x2e, 0x0e, 0xbe, 0x9a, 0xcb, 0x03,
                      0xef, 0x39, 0x4d, 0x42]),
                'purple': new Uint8Array([
                      0x18, 0xfd, 0xb9, 0x93, 0x0a, 0xef, 0xc4, 0x2b, 0x06, 0x80, 0x9c, 0x91,
                      0x6e, 0xbc, 0xe2, 0x72, 0x23, 0xe2, 0x13, 0xb0, 0xa3, 0xce, 0x35, 0x1f,
                      0xfc, 0x35, 0xae, 0x86, 0x18, 0x9c, 0xdd, 0x2d, 0xc2, 0x60, 0x80, 0x81,
                      0x75, 0xd3, 0xa3, 0x6d, 0xa9, 0xf0, 0x4d, 0x35, 0x55, 0x0a, 0x1c, 0xcc,
                      0x9d, 0x7f, 0xe7, 0x45, 0x10, 0x2c, 0x5e, 0x93, 0x6c, 0x23, 0x54, 0x5b,
                      0x59, 0x7d, 0x3d, 0x56, 0x1e, 0xf1, 0xd6, 0xe8, 0x0c, 0x3c, 0xce, 0x94,
                      0x76, 0xda, 0x43, 0x2f]),
                'navy blue': new Uint8Array([
                      0x10, 0x58, 0xbb, 0xa7, 0x73, 0xb7, 0xe0, 0xa9, 0x3f, 0x47, 0x2d, 0x0a,
                      0x98, 0x96, 0x89, 0x13, 0x0f, 0x8a, 0x1b, 0x1a, 0x71, 0x49, 0x7a, 0x70,
                      0x7b, 0xa1, 0xbe, 0x97, 0x0e, 0x0b, 0xa9, 0x5e, 0x3a, 0x1e, 0x2c, 0x66,
                      0x9c, 0x8f, 0x94, 0x36, 0x6c, 0xcc, 0xdf, 0x95, 0xf5, 0xeb, 0xac, 0x8a,
                      0x6d, 0x9f, 0x21, 0x8f, 0xaf, 0x79, 0x28, 0xc3, 0x18, 0x65, 0xf5, 0xb3,
                      0xc7, 0xfe, 0x55, 0xb4, 0x51, 0xc9, 0xfc, 0x2e, 0x37, 0x88, 0x5c, 0xa4,
                      0x74, 0x25, 0x51, 0x9b, 0x79, 0x2a, 0x84, 0xb0, 0xeb, 0x18, 0x5b, 0xaa,
                      0x95, 0xd6, 0x63, 0x50]),
                'white': new Uint8Array([
                      0x74, 0x40, 0x1c, 0xb6, 0x3a, 0xb9, 0x38, 0x6f, 0xea, 0xce, 0x12, 0xe8,
                      0x63, 0x15, 0x27, 0x3c, 0x05, 0xa1, 0x03, 0x65, 0x67, 0x12, 0x17, 0x6d,
                      0x48, 0x52, 0xad, 0xb9, 0xa1, 0x6d, 0xcf, 0xc5, 0x2d, 0xc5, 0x0b, 0xb6,
                      0xbd, 0x8e, 0xf1, 0xe2, 0x90, 0x92, 0xd7, 0x17, 0x3f, 0xb8, 0x9b, 0xa2,
                      0xfb, 0xf1, 0x87, 0x99, 0xf0, 0x00, 0x41, 0xdf, 0xdd, 0x72, 0x72, 0x85,
                      0xd9, 0x72, 0x8a, 0x21, 0x96, 0xb7, 0x63, 0x05, 0x36, 0x80, 0x19, 0xb1]),
            };

            let sensitivities = new Float32Array([0.5, 1, 1, 1, 1, 1]);

            let keywordNames = Object.keys(keywordIDs);

            let currentTimeSeconds = function() { return new Date().getTime() / 1000 };

            let is_listening = false;
            let listeningStartSeconds;
            let processCallback = function(keywordIndex) {
                if (keywordIndex === -1) {
                    if (is_listening && (currentTimeSeconds() - listeningStartSeconds) > 5) {
                        document.querySelector("#light_bulb").setAttribute("src", "light_bulb_blue.svg");
                        is_listening = false;
                    }
                    return;
                }

                let keyword = keywordNames[keywordIndex];
                if (is_listening) {
                    if (keyword === "yellow") {
                        document.querySelector("#light_bulb").setAttribute("style", "background-color:yellow")
                    }
                    if (keyword === "orange") {
                        document.querySelector("#light_bulb").setAttribute("style", "background-color:orange")
                    }
                    if (keyword === "purple") {
                        document.querySelector("#light_bulb").setAttribute("style", "background-color:purple")
                    }
                    if (keyword === "navy blue") {
                        document.querySelector("#light_bulb").setAttribute("style", "background-color:blue")
                    }
                    if (keyword === "white") {
                        document.querySelector("#light_bulb").setAttribute("style", "background-color:white")
                    }
                    document.querySelector("#light_bulb").setAttribute("src", "light_bulb_blue.svg");
                    is_listening = false;
                }
                if (keyword === "yellow") {
                    //document.querySelector("#light_bulb").setAttribute("src", "light_bulb_red.svg");
                    startButton(event);
                    //is_listening = true;
                    
                    //listeningStartSeconds = currentTimeSeconds();
                }
            };

            let audioManager;

            let audioManagerErrorCallback = function(ex) {
                alert(ex.toString());
                //document.querySelector("#light_bulb").setAttribute("style", "background-color:white");
                //document.querySelector("#light_bulb").setAttribute("src", "light_bulb_blue.svg");
                //document.querySelector("#demo_button").setAttribute("onclick", "VoiceControlDemo.start()");
                document.querySelector("#demo_button").setAttribute("onclick", "start()");
                //document.querySelector("#demo_button").innerText = "Start Demo";
                start_img.src = './mic.gif';
            };
            
            let start = function() {
                audioManager = new PicovoiceAudioManager();
                audioManager.start(Porcupine.create(Object.values(keywordIDs), sensitivities), processCallback, audioManagerErrorCallback);

                document.querySelector("#demo_button").setAttribute("onclick", "stop()");
                //document.querySelector("#demo_button").innerText = "Stop Demo";
                start_img.src = './mic.gif';
            };
            
            /*
            function start() {
                audioManager = new PicovoiceAudioManager();
                audioManager.start(Porcupine.create(Object.values(keywordIDs), sensitivities), processCallback, audioManagerErrorCallback);

                document.querySelector("#demo_button").setAttribute("onclick", "stop()");
                //document.querySelector("#demo_button").innerText = "Stop Demo";
                start_img.src = './mic.gif';
            };
            */

            let stop = function() {
                audioManager.stop();
                //document.querySelector("#light_bulb").setAttribute("style", "background-color:white");
                //document.querySelector("#light_bulb").setAttribute("src", "light_bulb_blue.svg");
                document.querySelector("#demo_button").setAttribute("onclick", "start()");
                //document.querySelector("#demo_button").innerText = "Start Demo";
                start_img.src = './mic-slash.gif';
            };
            
	var final_transcript = '';
	var recognizing = false;
	var ignore_onend;
	var start_timestamp;
	var search_input = document.getElementById('search_box'); // 자신의 검색 상자 태그ID를 여기에 넣습니다.
	var search_Button = document.getElementById('speech_img');
	// Browser Upgrade or Not supported Browser
	if (!('webkitSpeechRecognition' in window)) {
		upgrade();
	} else {
		search_box.style.display = 'inline-block';
		var recognition = new webkitSpeechRecognition();
		recognition.continuous = true;
		recognition.interimResults = false;
		recognition.onstart = function() {
		recognizing = true;
		start_img.src = './mic-animate.gif';
	};
	
	recognition.onerror = function(event) {
		if (event.error == 'no-speech') {
			start_img.src = './mic.gif';
			ignore_onend = true;
		}
		if (event.error == 'audio-capture') {
			start_img.src = './mic.gif';
			ignore_onend = true;
		}
		if (event.error == 'not-allowed') {
			ignore_onend = true;
		}
	};
	
	recognition.onend = function() {
		recognizing = false;
		if (ignore_onend) {
			return;
		}
		
		start_img.src = './mic.gif';
		
		if (!final_transcript) {
			return;
		}
		
		if (window.getSelection) {
			window.getSelection().removeAllRanges();
			var range = document.createRange();
			range.selectNode(search_input);
			window.getSelection().addRange(range);
		}
	};
	
	recognition.onresult = function(event) {
		var interim_transcript = '';
		for (var i = event.resultIndex; i < event.results.length; ++i) {
			if (event.results[i].isFinal) {
				final_transcript += event.results[i][0].transcript;
			} else {
				interim_transcript += event.results[i][0].transcript;
			}
		}

		final_transcript = capitalize(final_transcript);
		search_input.value = linebreak(final_transcript);
		ignore_onend=false;
		fnGetList();  // 내가 추가함
	};
}
	
setInterval(resetVoiceRecog, 10000);

function resetVoiceRecog() {
	if(ignore_onend==false){ 
		recognition.stop();
	}
}

//initialiseMediaPlayer();

function initialiseMediaPlayer(){
	recognition.lang = 'ko-KR'
	start();
}  
        
function searchVisible() {
	if(search_Button.style.display != 'inline-block') {
		search_Button.style.display = 'inline-block';
	} else {
		speech_Button.style.display = 'none';
	}
}
        
function searchHidden() {
	if(search_Button.style.display != 'none') {
		search_Button.style.display = 'none';
	}
}

function upgrade() {
	search_box.style.visibility = 'hidden';
}
            
var two_line = /\n\n/g;
var one_line = /\n/g;
        
function linebreak(s) {
	return s.replace(two_line, '<p></p>').replace(one_line, '<br>');
}
                
var first_char = /\S/;
   
function capitalize(s) {
	return s.replace(first_char, function(m) { return m.toUpperCase(); });
}
                
function startButton(event) {
	if (recognizing) {
		recognition.stop();
		return;
	}
        
    final_transcript = '';
    recognition.lang = 'ko-KR';
    recognition.start();
    ignore_onend = false;
    search_input.value = '';
    start_img.src = './mic-slash.gif';
    start_timestamp = event.timeStamp;
    
}
        


</script>