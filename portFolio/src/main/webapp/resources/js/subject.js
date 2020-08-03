function findsubject(sub,title){

    var check_count = document.getElementsByName("subject").length;
    
    var area = ["seoul1","pusan1","deagu1","incheon1","gwangju1",
		  "daejeon1","ulsan1","sejong1","gyeonggi1","gangwon1","chungb1",
		  "chungn1","jeollab1","jeollan1","gyeongb1","gyeongn1","jeju1","abroad1"];
  
    var list1=["math1","english1","korean1","foreign1","it1","science1","test1","society1"];
  
    for (var i=0; i<check_count; i++) {
        document.getElementsByName("subject")[i].checked = false;
    }
    
	  if(sub.style.display==""){//¾ø¾Ö±â
		  sub.style.display="none";
		  title.style.backgroundColor="white";
		  title.style.color="black";
	  	  }else{
	  		  //Å¸ÀÌÆ² »ö±ò ¹Ù²Ù±â
	  		  var subjecttitle = ["math1","english1","korean1","science1","society1",
	  			  "test1","foreign1","it1"];	
	  		  for (var i=0;i<8;i++){
	  	  		document.getElementById(subjecttitle[i]).style.backgroundColor="white";
	  	  		document.getElementById(subjecttitle[i]).style.color="black";
	  		  }
	  		title.style.backgroundColor="rgb(88, 193, 137)";
	  		title.style.color="white";
	  		//°ú¸ñ º¸¿©ÁÖ±â
	    	var subject = ["math","english","korean","science","society",
	  			  "test","foreign","it"];	
	    	for (var j=0;j<8;j++){
	    		document.getElementById(subject[j]).style.display="none";
	    	}
	    	sub.style.display="";
	  	 }
	  
      var index = 0;
      var flag1 = false;
      var flag2 = false;
      var sub1width = document.getElementById("area").clientHeight;
      var sub2width = document.getElementById("sub").clientHeight;
      var sub4width = document.getElementById("tfee").clientHeight;
      var sub5width = document.getElementById("ttime1").clientHeight;
      var sub6width = document.getElementById("ttime2").clientHeight;
      var sub7width = document.getElementById("tAge").clientHeight;
      
      var allwidth = 60;
      var somewidth = 80;
      var tsize1 = sub1width+sub2width+allwidth;
      var tsize2 = sub1width+sub4width+sub5width+sub6width+sub7width+somewidth;
      
      
      //Èñ¸ÁÁö¿ª
	  for (var i=0;i<18;i++){
  	  		if(document.getElementById(area[i]).style.color=="white"){
  	  			flag1 = true;
  	  		}
  		 }
	  
	  //Èñ¸Á°ú¸ñ
	    for(var i=0;i<list1.length;i++){
	    	if(document.getElementById(list1[i]).style.color=="white"){
	    		flag2 = true;
	    	}
	    }
	    
	    if(flag1==true&&flag2==true){
	    	index = 0;
	    }else if(flag1==true&&flag2==false){
	    	index = 1;
	    }else if(flag1==false&&flag2==true){
	    	index = 0;
	    }else{
	    	index = 1;
	    }

	    if(index==0){
	    	document.getElementById("searchv").style.height =tsize1+'px';
	    }
	    if(index==1){
	    	document.getElementById("searchv").style.height =tsize2+'px';
	    }
   
}


function findsubjects(sub,title){

    var check_count = document.getElementsByName("subject").length;
    
    var area = ["seoul1","pusan1","deagu1","incheon1","gwangju1",
		  "daejeon1","ulsan1","sejong1","gyeonggi1","gangwon1","chungb1",
		  "chungn1","jeollab1","jeollan1","gyeongb1","gyeongn1","jeju1","abroad1"];
  
    var list1=["math1","english1","korean1","foreign1","it1","science1","test1","society1"];
  
    for (var i=0; i<check_count; i++) {
        document.getElementsByName("subject")[i].checked = false;
    }
    
	  if(sub.style.display==""){//¾ø¾Ö±â
		  sub.style.display="none";
		  title.style.backgroundColor="white";
		  title.style.color="black";
	  	  }else{
	  		  //Å¸ÀÌÆ² »ö±ò ¹Ù²Ù±â
	  		  var subjecttitle = ["math1","english1","korean1","science1","society1",
	  			  "test1","foreign1","it1"];	
	  		  for (var i=0;i<8;i++){
	  	  		document.getElementById(subjecttitle[i]).style.backgroundColor="white";
	  	  		document.getElementById(subjecttitle[i]).style.color="black";
	  		  }
	  		title.style.backgroundColor="rgb(88, 193, 137)";
	  		title.style.color="white";
	  		//°ú¸ñ º¸¿©ÁÖ±â
	    	var subject = ["math","english","korean","science","society",
	  			  "test","foreign","it"];	
	    	for (var j=0;j<8;j++){
	    		document.getElementById(subject[j]).style.display="none";
	    	}
	    	sub.style.display="";
	  	 }
	  
      var index = 0;
      var flag1 = false;
      var flag2 = false;
      var sub1width = document.getElementById("area").clientHeight;
      var sub4width = document.getElementById("tfee").clientHeight;
      var sub5width = document.getElementById("ttime1").clientHeight;
      var sub6width = document.getElementById("ttime2").clientHeight;
      
      var allwidth = 60;
      var somewidth = 80;
      var tsize1 = sub1width+sub2width+allwidth;
      var tsize2 = sub1width+sub4width+sub5width+sub6width+somewidth;
      
      
      //Èñ¸ÁÁö¿ª
	  for (var i=0;i<18;i++){
  	  		if(document.getElementById(area[i]).style.color=="white"){
  	  			flag1 = true;
  	  		}
  		 }
	  
	  //Èñ¸Á°ú¸ñ
	    for(var i=0;i<list1.length;i++){
	    	if(document.getElementById(list1[i]).style.color=="white"){
	    		flag2 = true;
	    	}
	    }
	    
	    if(flag1==true&&flag2==true){
	    	index = 0;
	    }else if(flag1==true&&flag2==false){
	    	index = 1;
	    }else if(flag1==false&&flag2==true){
	    	index = 0;
	    }else{
	    	index = 1;
	    }

	    if(index==0){
	    	document.getElementById("searchv").style.height =tsize1+'px';
	    }
	    if(index==1){
	    	document.getElementById("searchv").style.height =tsize2+'px';
	    }
   
}