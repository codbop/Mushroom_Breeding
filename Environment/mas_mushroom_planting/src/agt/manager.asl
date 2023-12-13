// Agent manager in project mas_mushroom_planting

/* Initial beliefs and rules */

//!updateWeath.

/* Initial goals */
//!initiate.
!buyCompost.

/* Plans */

//+!initiate <- lookupArtifact("hall",HId)[wsp("depot")]; focus(HId)[wsp("depot")]. //; updateWeather().

//-!initiate <- .wait(500); .println("problem in initiate"); !initiate.

+!buyCompost <- .my_name(Me); makeArtifact("compost","tools.Compost",[""],CId); 
					focus(CId)[wsp("depot")]; println("ready").

-!buyCompost <- .wait(500); .println("problem in start"); !buyCompost.

+cmd("commitBuy") <- lookupArtifact("hall",HId)[wsp("depot")]; focus(HId)[wsp("depot")]; .wait(50);
						changeState("prepare"); initCompost;
						.broadcast(achieve,start); .println("start goal broadcast to agents").

+cmd("confirmDay",Input) <- validateDay(Input).

+dayChanged <- .println("Day Changed"); .send(expert,achieve,dayChanging).

+finished <- .wait(1000); changeState("empty"); finishPeriod.

//+endAll <- stopFocus(CId); stopFocus(HId); quitWorkspace([wsp("depot")]). 

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
