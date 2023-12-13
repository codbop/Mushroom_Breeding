// Agent expert in project mas_mushroom_planting

/* Initial beliefs and rules */
org_name("depot_org").
group_name("depot_gr").
sch_name("depot_sch").
work_sp("depot").
role_name("expert").
/* Initial goals */
!init.

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
   <- .println(Ag," obliged to achieve goal ",Goal);
      !Goal[scheme(Scheme)];
      goalAchieved(Goal)[artifact_name(Scheme)].
      
+obligation(Ag,Norm,What,Deadline)  
   : .my_name(Ag)
   <- .print(Ag," obliged to ",What,", but I don't know what to do!").


+soilPour <- isDirty; .wait(1500); changeCState("soilPour") .println("soil pouring and irrigating done").  

+raffling <- isDirty; .wait(1500); changeCState("raffling") .println("raffling done").

+shock1 <- .send(conditionCare,tell,shck1); isDirty; changeCState("shocking") .println("1st shocking done").
+shock2 <- .send(conditionCare,tell,shck2); isDirty; .println("2nd shocking done").
+shock3 <- .send(conditionCare,tell,shck3); isDirty; .println("3rd shocking done").

+moderate <- .send(conditionCare,tell,mdrt); isDirty; changeCState("waitHarvest").

+harvest <- .send(worker,achieve,hrvst); isDirty; changeCState("harvest").

+removeC <- .send(worker,tell,rcmp); isDirty; .wait(1000);
			changeCState("useless"); .println("Hall is evacuated from compost").

/*
+!setup  <- lookupArtifact("depot_gr",Dgrp)[wsp("depot_org")]; //[wid(Dorg)];
			adoptRole("expert")[artifact_id(Dgrp)];
			.println("expert Role adopted"); .wait(100);
			
			//.println("Going to add scheme ...");
      		//addScheme(Schname)[artifact_id(Dgrp)];
      		//.println("Scheme added");   		
      		
			lookupArtifact("depot_sch",Dsch)[wid(Dorg)];
			.println("lookup scheme finished"); .wait(100);
			commitMission("mBeginn")[artifact_id(Dsch)]; 
			.println("Committed to mission begin"); .wait(100); !cntu.


-!setup <- .wait(1000); .println("Problem in Setup"); !setup.

+!cntu <- .wait(5000); joinWorkspace("depot",Dws); println("ready");
			goalAchieved("beginn")[artifact_id(Dsch)];
      		.println("beginn Goal achieved"). 
-!cntu <- .wait(1000); .println("Problem in cntu"); !cntu.

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
 */

{include("inc/agoals.asl")}
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
