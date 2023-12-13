// CArtAgO artifact code for project mas_mushroom_planting

package tools;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;


public class DisplayHall extends JFrame {

	public JLabel tempLabel, tempNo, humidLabel, humidNo, stateLabel, stateValue, cleanLabel, cleanValue;
	public DisplayHall(String title) {
		setTitle(".::" +title+ "Hall-CONDITION CONSOLE ::.");
		setSize(460,300);
		
		JPanel panel = new JPanel();
		setContentPane(panel);
		panel.setLayout(new BoxLayout(panel,BoxLayout.Y_AXIS));
				
		JPanel p1 = new JPanel();
		tempLabel = new JLabel("Temperature °c : ");
		tempNo = new JLabel("");
		p1.add(tempLabel);
		p1.add(tempNo);
		panel.add(p1);
		
		JPanel p2 = new JPanel();
		humidLabel = new JLabel("Humidity % : ");
		humidNo = new JLabel("");
		p2.add(humidLabel);
		p2.add(humidNo);
		panel.add(p2);
		
		JPanel p3 = new JPanel();
		stateLabel = new JLabel("State : ");
		stateValue = new JLabel("empty");
		p3.add(stateLabel);
		p3.add(stateValue);
		panel.add(p3);
		
		JPanel p4 = new JPanel();
		cleanLabel = new JLabel("Is Clean : ");
		cleanValue = new JLabel("No");
		p4.add(cleanLabel);
		p4.add(cleanValue);
		panel.add(p4);
	}
	
	public void editTemp(final String s){
        SwingUtilities.invokeLater(new Runnable(){
            public void run() {
                tempNo.setText(s);
            }
        });
    }
	
	public void editHumid(final String s){
        SwingUtilities.invokeLater(new Runnable(){
            public void run() {
                humidNo.setText(s);
            }
        });
    }

}

