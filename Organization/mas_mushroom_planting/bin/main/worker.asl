// Agent worker in project mas_mushroom_planting

/* Initial beliefs and rules */
org_name("depot_org").
group_name("depot_gr").
sch_name("depot_sch").
work_sp("depot").
role_name("worker").
/* Initial goals */
!init.
//start.

/* Plans */
+!init : group_name(Gr) & sch_name(Sch) & role_name(Role) <- 
			.my_name(Me); .println("Hello from ", Me);
			//lookupArtifact("hall",HID)[wsp("depot")]; doClean;
			.println(Me," joined remote workspace").

+obligation(Ag,Norm,committed(Ag,Mission,Scheme),Deadline)
    : .my_name(Ag)
   <- .println(Ag," obliged to commit to ",Mission," on ",Scheme);
      commitMission(Mission)[artifact_name(Scheme)].
      
+obligation(Ag,Norm,done(Scheme,Goal,Ag),Deadline)
    : .my_name(Ag)
   <- .println(Ag, " obliged to achieve goal ",Goal);
      !Goal[scheme(Scheme)];
      goalAchieved(Goal)[artifact_name(Scheme)].
      
+obligation(Ag,Norm,What,Deadline)  
   : .my_name(Ag)
   <- .print(Ag," obliged to ",What,", but I don't know what to do!").
//+start <- joinWorkspace("depot",Id); .print("hello from worker."); .wait(500); !conArtifact. 

/*
+!start <- lookupArtifact("compost",CId)[wsp("depot")];
	   focus(CId)[wsp("depot")]; .println("Hello I am worker agent and waiting for Hall condition").

//joinWorkspace("depot",Id); .wait(100); 
-!start <- .wait(500); .println("problem in joining worker"); !start.

+state("ready") <- .println("compost placing in the Hall ..."); .wait(1000); .wait(1000); .wait(1000); .wait(1000); .wait(1000);
					 .println("compost placed in the Hall done"); .send(expert,tell,placed).

+harvest <- .println("doing harvest ...") .wait(1000); .wait(1000); .wait(1000); .wait(1000); .println("harvest done").
+removeC <- .println("removing useless compost ..."); .wait(1000); .wait(1000); .wait(1000); .wait(1000); .wait(1000); 
				.println("compost removed from hall"); .send(expert,tell,removed).
*/

{include("inc/agoals.asl")}
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
