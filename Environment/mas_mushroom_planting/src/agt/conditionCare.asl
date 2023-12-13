// Agent conditionCare in project mas_mushroom_planting

/* Initial beliefs and rules */

/* Initial goals */


/* Plans */

+!start <- lookupArtifact("hall",HId)[wsp("depot")]; focus(HId)[wsp("depot")]; .wait(50);
			lookupArtifact("airCond",AId)[wsp("depot")]; focus(AId)[wsp("depot")]; .wait(50);
			linkArtifacts(AId,"wth-port",HId); readTemp(T); readHumid(H);
			.wait(1000); .wait(1000); .wait(1000); .wait(1000); initWeather(25,75); .send(expert,tell,wthMod). 

//lookupArtifact("compost",CId)[wsp("depot")]; focus(CId)[wsp("depot")]; .println("Hello I am cond-care agent"). 
-!start <- .wait(500); .println("problem in joining by cond-care"); !start.

+shock1 <- .wait(1000); .wait(1000); initWeather(18,90); .println("temperature set to 18 and humidity set to 90% ").
+shock2 <-  .wait(1000); .wait(1000); initWeather(17,90); .println("temperature set to 17 and humidity keep 90% ").
+shock3 <-  .wait(1000); .wait(1000); initWeather(16,90); .println("temperature set to 16 and humidity keep 90% ").

+moderate <- .wait(1000); .wait(1000); initWeather(19,85); .println("temperature set to 19 and humidity set to 85% ").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
