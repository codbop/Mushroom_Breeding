// Agent agoals in project mas_mushroom_planting

+!mushBreed <- .println("achieve mushbreed").

/* +!beginn <- .println("11111111"); 
 			.wait(1000); .println("manager done goal beginn").//; updateDay("1")[artifact_id(CId)].

-!beginn <- .wait(100); .println("problem in joining by manager"); !beginn.
*/

+!clean <- .println("222222222"); lookupArtifact("hall",HId)[wsp("depot")]; focus(HId)[wsp("depot")];
 			.wait(5000); doClean; 
			changeState("prepare");
 			.println("hlthCtrl done goal clean").
			//lookupArtifact("hall",HId)[wsp("depot")]; focus(HId)[wsp("depot")]; .wait(50); doClean.

-!clean <- .wait(100); .println("problem in joining by hlthCtrl"); !clean.


+!moderate <- .println("33333333"); 
			lookupArtifact("hall",HId)[wsp("depot")]; focus(HId)[wsp("depot")]; 
			.wait(50); lookupArtifact("airCond",AId)[wsp("depot")]; focus(AId)[wsp("depot")]; 
			.wait(50); 
			linkArtifacts(AId,"wth-port",HId)[wsp("depot")]; 
			readTemp(T); readHumid(H);
			.wait(3000); initWeather(25,75);//[wsp("depot")].
			changeState("ready").

-!moderate <- .wait(100); .println("problme in joining by condCare"); !moderate.


+!placeCompost <- .println("44444444"); .wait(6000); 
				lookupArtifact("hall",HId)[wsp("depot")]; 
				focus(HId)[wsp("depot")]; .wait(100);
 				changeState("placed");
				.println("worker placed all compost into hall").

-!placeCompost <- .wait(100); .println("problme in joining by worker"); !placeCompost.


+!changeStatus <- .println("55555555"); lookupArtifact("compost",CId)[wsp("depot")]; 
				focus(CId)[wsp("depot")]; .wait(1000);
 				initCompost; .println("expert done change compost status").

-!changeStaus <- .wait(100); .println("problme in joining by expert"); !changeStatus.


+!dayChange <- .println("66666666"); 
				//lookupArtifact("compost",CId)[wsp("depot")]; focus(CId)[wsp("depot")];
				//incDay(2);
				!checkSchedule. 

-!dayChange <- .wait(100); .println("problme in joining by manager in day change").

+!checkSchedule : dayno(Ad) & Ad<=5 <- 
				.wait(500);
				-+dayno(Ad+1);
	   			.println(Ad);
	   			incDay(Ad);
	   			isDirty;
	   			.send(healthCare,achieve,dailyClean); //synchronization mechanism
	   			//checkSchedule() in hall
				!checkSchedule.	   			

+!checkSchedule : true.


//+ageDay(Ad) <- .println("zzzzz", Ad); incDay(Ad).


