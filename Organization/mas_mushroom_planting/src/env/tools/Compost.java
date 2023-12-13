// CArtAgO artifact code for project mas_mushroom_planting

package tools;

import java.awt.event.ActionEvent;

import javax.swing.SwingUtilities;

import cartago.*;
import cartago.tools.GUIArtifact;

public class Compost extends GUIArtifact {
	
	private Display display;
	public String[] stateList = {"mycelium", "soilPour", "raffling", "shocking", "waitHarvest", "harvest", "useless"};
	public void init(String title) {
		display = new Display(title);
		linkActionEventToOp(display.buyCompost,"commitBuy");
		linkActionEventToOp(display.confirm,"confirmDay");
		display.setVisible(false);
		log("set visible true");
		defineObsProperty("ageDay", 1);
		defineObsProperty("cState", "mycelium");
		this.init();
	}

	@INTERNAL_OPERATION void commitBuy(ActionEvent ev){
    	this.signal("cmd","commitBuy");
    }
	
	@INTERNAL_OPERATION void confirmDay(ActionEvent ev){
    	this.signal("cmd", "confirmDay",display.ageDay.getText());
    }
	
	@OPERATION void updateDay(String dayNo) {
		if (display.confirm.isEnabled() != true) {
			display.confirm.setEnabled(true);
			display.ageDay.setEnabled(true);
		}
		display.addText(dayNo);		
		ObsProperty prop = getObsProperty("ageDay");
		prop.updateValue(Integer.parseInt(dayNo));
		signal("tickDay");
	}
	
	@OPERATION void getDay(OpFeedbackParam<Integer> D) {
		ObsProperty prop = getObsProperty("ageDay");
		D.set(prop.intValue());
	}
	
	@OPERATION void incDay(int d) {
		ObsProperty prop = getObsProperty("ageDay");
		display.addText(Integer.toString(d));
		prop.updateValue(d);
		if (d == 14) {
			//log("soil pouring " + Integer.toString(d));
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
		} else if (d == 28) {
			//log("moderate the weather");
			signal("moderate");
		} else if (d >= 38 && d <= 44) {
			//log("1st harvest");
			signal("harvest");
		} else if (d>= 46 && d<= 52) {
			//log("2nd harvest");
			signal("harvest");
		} else if (d>= 54 && d<= 59) {
			//log("3rd harvest");
			signal("harvest");
		} else if (d == 60) {
			//log("Clean up the hall and remove the compost");
			signal("removeC");
		} else {
			signal("dayChanged");
		}
	}
	
	@OPERATION void enableCompost() {
		display.setVisible(true);
		display.confirm.setVisible(false);
		//display.cStateLabel.setVisible(true);
		//display.cState.setVisible(true);
	}
	
	@OPERATION void initCompost() {
		//display.setVisible(true);
		display.cStateLabel.setVisible(true);
		display.cState.setVisible(true);
		display.ageDay.setEnabled(true);
		display.ageDay.setEditable(false);
		ObsProperty prop = getObsProperty("ageDay");
		prop.updateValue(prop.intValue()+1);
		display.addText("1");
	}
	
	@OPERATION void changeCState(String st) {
		ObsProperty prop = getObsProperty("cState");
		prop.updateValue(st);
		display.cState.setText(st);
		signal("cStateChange");
	}
	
	@OPERATION void finishPeriod() {
		display.cStateLabel.setVisible(false);
		display.cState.setVisible(false);
		signal("endAll");
	}
}

