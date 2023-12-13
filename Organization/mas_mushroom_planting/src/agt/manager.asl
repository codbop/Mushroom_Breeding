// Agent manager in project mas_mushroom_planting

/* Initial beliefs and rules */
my_group("depot_gr").
my_scheme("depot_sch").
//my_org("depot_org").
my_role("manager").

dayno(1).
//!updateWeath.

/* Initial goals */
!init.
//!buyCompost.

/* Plans */

+!init : true <- .my_name(Me); .println("Hello from ", Me);
			//makeArtifact("compost","tools.Compost","",CId);
			//focus(CId)[wsp("depot")];
			joinRemoteWorkspace("depot","localhost",Dws);
			joinRemoteWorkspace("depot_org","localhost",Dorg);
			.println(Me," joined remote workspace");
			lookupArtifact("compost",CId)[wsp("depot")]; focus(CId)[wsp("depot")]; .wait(50);
			enableCompost.
			//changeState("prepare"); initCompost.
			//joinWorkspace("depot_org",Dorg).
					
-!init <- .wait(1000); .println("problem in manager init"); !init.

+cmd("commitBuy") <- lookupArtifact("depot_gr",Dgrp)[wid(Dorg)];
					focus(Dgrp)[wid("depot_org")];
					
					adoptRole("manager")[artifact_id(Dgrp)];
					.println("manager Role adopted"); .wait(1000);
					//.println("Going to add scheme ...");
	    	  		//addScheme(Schname)[artifact_id(Dgrp)];
		      		//.println("Scheme added");   		
      				?formationStatus(ok)[artifact_id(Dgrp)]; // see plan below to ensure we wait until it is well formed
      				addScheme("depot_sch")[artifact_id(Dgrp)];
					lookupArtifact("depot_sch",Dsch)[wid(Dorg)];
					focus(Dsch)[wid("depot_org")];
										
					commitMission("mDayChange")[artifact_id(Dsch)]; 
					.println("Committed to mission dayChange");
					.wait(500).
					
					//goalAchieved("beginn")[artifact_id(Dsch)];
      				//.println("beginn Goal achieved").
      				
+?formationStatus(ok)[artifact_id(G)]
   <- .wait({+formationStatus(ok)[artifact_id(G)]}).
/*
+cmd("confirmDay",Input) <- //validateDay(Input).
							adoptRole("dayChanger")[artifact_id(Dgrp)];
							.println("dayChanger Role adopted"); .wait(1000);
							commitMission("mDayChange")[artifact_id(Dsch)]; 
							.println("Committed to mission dayChange"); .wait(500).
*/

// plans to handle obligations
+obligation(Ag,Norm,committed(Ag,Mission,Scheme),Deadline)
    : .my_name(Ag)
   <- .time(H,M,S);
   		.println(H,":",M,":",S," ", Ag," obliged to commit to ",Mission," on ",Scheme);
      	commitMission(Mission)[artifact_name(Scheme)].
      
//+obligation(Ag,Norm,achieved(Scheme,Goal,Ag),Deadline)
+obligation(Ag,Norm,done(Scheme,Goal,Ag),Deadline)
    : .my_name(Ag)
   <- .time(Ho,Mi,Se);
   		.println(Ho,":",Mi,":",Se," ", Ag," obliged to achieve goal ",Goal);
     	!Goal[scheme(Scheme)];
      	goalAchieved(Goal)[artifact_name(Scheme)].
      
+obligation(Ag,Norm,What,Deadline)  
   : .my_name(Ag)
   <- .print(Ag," obliged to ",What,", but I don't know what to do!").

+dayChanged <- isDirty; .wait(1000). 


/*
+!mushBreed	<-	.println("Achieving mushBreed").

+!buyCompost  : my_group(Gr) & my_scheme(Sch) & my_role(Role) <-
					.my_name(Me); lookupArtifact("compost",CId)[wsp("depot")];//makeArtifact("compost","tools.Compost",[""],CId); 
					focus(CId)[wsp("depot")]; .wait(50); .println("ready").

-!buyCompost <- .wait(500); .println("problem in start"); !buyCompost.

+cmd("commitBuy") <- lookupArtifact("hall",HId)[wsp("depot")]; focus(HId)[wsp("depot")]; .wait(50);
						changeState("prepare"); initCompost;
						.send(expert,achieve,setup); .println("setup goal broadcast to agents"). //.broadcast(achieve,setup)

+cmd("confirmDay",Input) <- validateDay(Input).

+dayChanged <- .println("Day Changed"); .send(expert,achieve,dayChanging).

+finished <- .wait(1000); changeState("empty"); finishPeriod.

//+endAll <- stopFocus(CId); stopFocus(HId); quitWorkspace([wsp("depot")]). 
*/

{include("inc/agoals.asl")}

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
