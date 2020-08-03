function tday(ju){
	var title = document.getElementById(ju); // 값불러오기 
	f = document.frm; //버튼 
	f.dbtn.value= title.textContent; //버튼에 값 넣기
	//색 바꾸기
	  var list = ["ju2","ju3","ju5","jua"];
		  for (var i=0;i<4;i++){
	  		document.getElementById(list[i]).style.backgroundColor="white";
	  		document.getElementById(list[i]).style.color="black";
		  }
	title.style.backgroundColor="rgb(88, 193, 137)";
	title.style.color="white";
}

function tGender(man){
	var title = document.getElementById(man); // 값불러오기 
	f = document.frm; //버튼 
	f.gbtn.value= title.textContent; //버튼에 값 넣기
	//색 바꾸기
	 var list = ["man","woman","human"];
		  for (var i=0;i<3;i++){
	  		document.getElementById(list[i]).style.backgroundColor="white";
	  		document.getElementById(list[i]).style.color="black";
		  }
	title.style.backgroundColor="rgb(88, 193, 137)";
	title.style.color="white";
}

function tfee(fee){
	var title = document.getElementById(fee); // 값불러오기 
	f = document.frm; //버튼 
	f.fbtn.value= title.textContent; //버튼에 값 넣기
	//색 바꾸기
	 var list = ["f30","f40","f50","f60","f70","fa"];
		  for (var i=0;i<6;i++){
	  		document.getElementById(list[i]).style.backgroundColor="white";
	  		document.getElementById(list[i]).style.color="black";
		  }
	title.style.backgroundColor="rgb(88, 193, 137)";
	title.style.color="white";
}

function ttime(time){
	var title = document.getElementById(time); // 값불러오기 
	f = document.frm; //버튼 
	f.tbtn.value= title.textContent; //버튼에 값 넣기
	//색 바꾸기
	 var list = ["tmornig","tafternoon","tevening","tall"];
		  for (var i=0;i<4;i++){
	  		document.getElementById(list[i]).style.backgroundColor="white";
	  		document.getElementById(list[i]).style.color="black";
		  }
	title.style.backgroundColor="rgb(88, 193, 137)";
	title.style.color="white";
}

function tobj(obj){
	var title = document.getElementById(obj); // 값불러오기 
	f = document.frm; //버튼 
	f.tobj.value= title.textContent; //버튼에 값 넣기
	//색 바꾸기(사용안함)
/*	if(obj=="obj6"){
		 var list = ["obj1","obj2","obj3","obj4","obj5","obj6"];
		  for (var i=0;i<6;i++){
	  		document.getElementById(list[i]).style.backgroundColor="white";
	  		document.getElementById(list[i]).style.color="black";
		  }
	}
	else{*/
	 var list = ["obj1","obj2","obj3","obj4","obj5","obj6"];
		  for (var i=0;i<6;i++){
	  		document.getElementById(list[i]).style.backgroundColor="white";
	  		document.getElementById(list[i]).style.color="black";
		  }
	title.style.backgroundColor="rgb(88, 193, 137)";
	title.style.color="white";
}