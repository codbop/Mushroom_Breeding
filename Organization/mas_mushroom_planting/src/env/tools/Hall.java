// CArtAgO artifact code for project mas_mushroom_planting

package tools;

import cartago.*;

public class Hall extends Artifact {
	
	private DisplayHall displayHall;
	public String[] stateList = {"empty", "prepare", "ready", "placed"};
	private boolean doModerate;
	void init() {
		displayHall = new DisplayHall("");
    	displayHall.setVisible(true);
    	
		defineObsProperty("temperature", 27);
		defineObsProperty("humidity", 35);
		defineObsProperty("state", "empty");
		defineObsProperty("isClean", false);
		doModerate = false;
		displayHall.tempNo.setText(getObsProperty("temperature").getValue().toString());
		displayHall.humidNo.setText(getObsProperty("humidity").getValue().toString());
	}
	
	@OPERATION void changeState(String state) {
		ObsProperty prop = getObsProperty("state");
		prop.updateValue(state);
		displayHall.stateValue.setText(state);
	}
	
	@OPERATION void doClean() {
		ObsProperty prop = getObsProperty("isClean");
		if(prop.booleanValue() != true) {
			prop.updateValue(true);
			displayHall.cleanValue.setText("Yes");
			signal("clean");
		} else {
			//it is also cleaned before
		}
	}
	
	@OPERATION void isDirty() {
		ObsProperty stProp = getObsProperty("state");
		if (stProp.getValue().toString().trim().equals("placed")) {
			ObsProperty prop = getObsProperty("isClean");
			prop.updateValue(false);
			displayHall.cleanValue.setText("No");
			signal("dirty");
		}
	}
	
	@LINK void getTemp(OpFeedbackParam<Integer> t) {
		t.set(getObsProperty("temperature").intValue());
	}
	
	@LINK void getHumid(OpFeedbackParam<Integer> h) {
		h.set(getObsProperty("humidity").intValue());
	}
	
	@LINK void updateWeahter(int tmp, int hmd) {
		ObsProperty prop = getObsProperty("temperature");
		prop.updateValue(tmp);
		displayHall.editTemp(prop.getValue().toString());
		
		ObsProperty propH = getObsProperty("humidity");
		propH.updateValue(hmd);
		displayHall.editHumid(propH.getValue().toString());
		//prop.updateValue(Integer.parseInt(dayNo));
		signal("tickWeath");
	}
	
	@OPERATION void checkPlan(int d) {
		log("checkPlan " + Integer.toString(d));
		if (d == 14) {
			log("soil pouring " + Integer.toString(d));
			//log("do soil pouring and irrigation");
			signal("soilPour");
		} else if (d ==21) {
			//log("do raffling task");
			signal("raffling");
		} else if (d == 25) {
			//log("1st day shocking that must update weather");
			signal("shock1");
		} else if (d == 26) {
			//log("2ndt day shocking that must update weather");
			signal("shock2");
		} else if (d == 27) {
			//log("3rd day shocking that must update weather");
			signal("shock3");
		} else if (d > 27) {
			//log("moderat the weather");
			if(doModerate == false) {
				signal("moderate");
				doModerate = true;
			}
			if (d >= 38 && d <= 44) {
				//log("1st harvest");
				signal("harvest");
			} else if (d>= 46 && d<= 52) {
				//log("2nd harvest");
				signal("harvest");
			} else if (d>= 54 && d<60) {
				//log("3rd harvest");
				signal("harvest");
			} else if (d == 60) {
				//log("Clean up the hall and remove the compost");
				signal("removeC");
			}
		}
	}
}

