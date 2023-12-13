// Agent healthCare in project mas_mushroom_planting

/* Initial beliefs and rules */
org_name("depot_org").
group_name("depot_gr").
sch_name("depot_sch").
work_sp("depot").
role_name("hlthCtrl").

/* Initial goals */
!init.

/* Plans */
+!init : group_name(Gr) & sch_name(Sch) & role_name(Role) <- 
			.my_name(Me); .println("Hello from ", Me);
			//lookupArtifact("hall",HID)[wsp("depot")]; doClean;
			.println(Me," joined remote workspace").
				
+dirty <- .wait(1000); doClean.// ; dirty.			
/*
+!setup : org_name(Oname) & group_name(Gname) & sch_name(Schname) & role_name(Rolename) <-
			joinWorkspace(Oname,WOrg); .println("joined depot org"); .wait(100);
			lookupArtifact(Gname,Dgrp)[wid(WOrg)];
			adoptRole(Rolename)[artifact_id(Dgrp)];
			.println("hlthCtrl Role adopted"); .wait(100);
			
			//.println("Going to add scheme ...");
      		//addScheme(Schname)[artifact_id(Dgrp)];
      		//.println("Scheme added");
      		
			lookupArtifact(Schname,Dsch)[wid(WOrg)];
			.println("clean lookup scheme finished"); .wait(100);
			commitMission("mClean")[artifact_id(Dsch)]; 
			.println("Committed to mission clean"); .wait(100);
			//!clean[scheme(Dsch)];
      		goalAchieved("clean")[artifact_id(Dsch)];
      		.println("clean Goal achieved").
      		//?formationStatus(ok)[artifact_id(Dgrp)]; // see plan below to ensure we wait until it is well formed
     		//addScheme(Schname)[artifact_id(Dgrp)].

-!setup <- .wait(1000); .println("Problem in Setup"); !setup.
*/

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
 
/*
+!start <- lookupArtifact("hall",HId)[wsp("depot")]; focus(HId)[wsp("depot")]; .wait(50); doClean.

-!start <- .wait(500); .println("problem in joining by health-care"); !start.

+dirty <- .wait(1000); .wait(1000); .wait(1000); doClean; .println("Hall has been cleaned").
*/

{include("inc/agoals.asl")}
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
