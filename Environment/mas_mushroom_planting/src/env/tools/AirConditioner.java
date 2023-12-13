// CArtAgO artifact code for project mas_mushroom_planting

package tools;

import cartago.*;

@ARTIFACT_INFO (outports={@OUTPORT(name= "wth-port")})

public class AirConditioner extends Artifact {
	private boolean working; 
	void init() {
		working = true;
	}
	
	@OPERATION void readTemp(OpFeedbackParam<Integer> t) {
		log("executing readTemp");
		try {
			execLinkedOp("wth-port", "getTemp", t);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	@OPERATION void readHumid(OpFeedbackParam<Integer> h) {
		log("executing readHumdi");
		try {
			execLinkedOp("wth-port", "getHumid", h);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	@OPERATION void initWeather(int tmp, int hmd) {
		log("executing update weather");
		try {
			execLinkedOp("wth-port", "updateWeahter", tmp, hmd);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	@OPERATION void checkWorkingState(String state) {
		//if state is wrecked, call manager to fix by updating state to wrecked
		await("notWorking");
		signal("tick");
	}
	
	@GUARD boolean notWorking(){
    	return working;
    }
	
}

