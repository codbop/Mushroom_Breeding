// Agent expert in project mas_mushroom_planting

/* Initial beliefs and rules */

/* Initial goals */


/* Plans */

+!start <- lookupArtifact("compost",CId)[wsp("depot")];
	   		focus(CId)[wsp("depot")]; .println("Hello I am expert agent"); updateDay("1").
//joinWorkspace("depot",Id); .wait(100);


-!start <- .wait(500); .println("problem in joining by expert"); !start.

+wthMod<- changeState("ready"); .println("Hall state changed to ready").

+placed <- changeState("placed"); .println("Hall state changed to placed").

+!dayChanging <- isDirty; getDay(D); checkSchedule(D).

-!dayChanging <- .wait(500); .println("problem in dayChanging by expert"); !dayChanging.

+soilPour <- .println("doing soil pouring and irrigating ...");.wait(1000); .wait(1000); .wait(1000); 
				changeCState("soilPour") .println("soil pouring and irrigating done").

+raffling <- .println("do raffling ..."); .wait(1000); .wait(1000); .wait(1000); 
				changeCState("raffling") .println("raffling done").

+shock1 <- .println("doing 1st day shocking ..."); .wait(1000); .wait(1000); .wait(1000); 
				changeCState("shocking") .println("1st shocking done").
+shock2 <- .println("doing 2nd day shocking ..."); .wait(1000); .wait(1000); .wait(1000); 
				changeCState("shocking") .println("2nd shocking done").
+shock3 <- .println("doing 3rd day shocking ..."); .wait(1000); .wait(1000); .wait(1000); 
				changeCState("shocking") .println("3rd shocking done").

+moderate <- .wait(1000); .wait(1000); .wait(1000); changeCState("waitHarvest").

+harvest <- .wait(1000); changeCState("harvest").

+removed <- changeCState("useless"); .wait(1000); .println("Hall is evacuated from compost"); .send(manager,tell,finished).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
