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
		display.setVisible(true);
		defineObsProperty("ageDay", 0);
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
	
	@OPERATION void validateDay(String d) {
		ObsProperty prop = getObsProperty("ageDay");
		if (Integer.parseInt(d) > prop.intValue()) {
			display.addText(d);
			prop.updateValue(Integer.parseInt(d));
			signal("dayChanged");
		} else {
			log("Invaldi day");
		}
		
	}
	
	@OPERATION void initCompost( ) {
		display.cStateLabel.setVisible(true);
		display.cState.setVisible(true);
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

