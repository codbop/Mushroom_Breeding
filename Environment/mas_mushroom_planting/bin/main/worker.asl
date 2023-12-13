// Agent worker in project mas_mushroom_planting

/* Initial beliefs and rules */

/* Initial goals */

//start.

/* Plans */

//+start <- joinWorkspace("depot",Id); .print("hello from worker."); .wait(500); !conArtifact. 

+!start <- lookupArtifact("compost",CId)[wsp("depot")];
	   focus(CId)[wsp("depot")]; .println("Hello I am worker agent and waiting for Hall condition").

//joinWorkspace("depot",Id); .wait(100); 
-!start <- .wait(500); .println("problem in joining worker"); !start.

+state("ready") <- .println("compost placing in the Hall ..."); .wait(1000); .wait(1000); .wait(1000); .wait(1000); .wait(1000);
					 .println("compost placed in the Hall done"); .send(expert,tell,placed).

+harvest <- .println("doing harvest ...") .wait(1000); .wait(1000); .wait(1000); .wait(1000); .println("harvest done").
+removeC <- .println("removing useless compost ..."); .wait(1000); .wait(1000); .wait(1000); .wait(1000); .wait(1000); 
				.println("compost removed from hall"); .send(expert,tell,removed).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
