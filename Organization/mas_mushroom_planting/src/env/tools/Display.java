// CArtAgO artifact code for project mas_mushroom_planting

package tools;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;


public class Display extends JFrame {

	public JButton buyCompost, confirm;
	public JTextField ageDay;
	public JLabel cStateLabel, cState;
	public Display(String title) {
		setTitle(".::" +title+ "DAY-MANAGEMENT CONSOLE ::.");
		setSize(460,200);
		
		JPanel panel = new JPanel();
		setContentPane(panel);
		panel.setLayout(new BoxLayout(panel,BoxLayout.Y_AXIS));
				
		JPanel p1 = new JPanel();
		buyCompost = new JButton("buyCompost");
		p1.add(buyCompost);
		panel.add(p1);
		
		JPanel p2 = new JPanel();
		confirm = new JButton("confirm");
		ageDay = new JTextField(10);
		p2.add(confirm);
		p2.add(ageDay);
		panel.add(p2);
		
		JPanel p3 = new JPanel();
		cStateLabel = new JLabel("state: ");
		cState = new JLabel("mycelium");
		p3.add(cStateLabel);
		p3.add(cState);
		panel.add(p3);
		
		confirm.setEnabled(false);
		ageDay.setEnabled(false);
		cStateLabel.setVisible(false);
		cState.setVisible(false);
	}
	
	public void addText(final String s){
        SwingUtilities.invokeLater(new Runnable(){
            public void run() {
                ageDay.setText(s);
            }
        });
    }

}

