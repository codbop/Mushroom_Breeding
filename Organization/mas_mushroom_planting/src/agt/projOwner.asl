// Agent org_agent in project mas_mushroom_planting

/* Initial beliefs and rules */
org_name("depot_org").
group_name("depot_gr").
sch_name("depot_sch").
work_sp("depot").
role_name("pOwner").

/* Initial goals */

!setup_and_init.

/* Plans */

+!setup_and_init : group_name(Gr) & sch_name(Sch) & role_name(Role) <- 
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

+!beginn <- .println("11111111"); 
 			.wait(1000); .println("manager done goal beginn").//; updateDay("1")[artifact_id(CId)].

-!beginn <- .wait(100); .println("problem in joining by manager"); !beginn.

{ include("inc/skills.asl") }
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
