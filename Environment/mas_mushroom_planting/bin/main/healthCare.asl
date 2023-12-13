// Agent healthCare in project mas_mushroom_planting

/* Initial beliefs and rules */

/* Initial goals */


/* Plans */

+!start <- lookupArtifact("hall",HId)[wsp("depot")]; focus(HId)[wsp("depot")]; .wait(50); doClean.

-!start <- .wait(500); .println("problem in joining by health-care"); !start.

+dirty <- .wait(1000); .wait(1000); .wait(1000); doClean; .println("Hall has been cleaned").


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
