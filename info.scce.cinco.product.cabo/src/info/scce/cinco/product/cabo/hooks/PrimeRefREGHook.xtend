package info.scce.cinco.product.cabo.hooks;

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.cabo.kabelplan.kabelplan.REG
import info.scce.cinco.product.cabo.regs.regkomponentenbibliothek.PhasePort
import info.scce.cinco.product.cabo.regs.regkomponentenbibliothek.NeutralPort
import info.scce.cinco.product.cabo.regs.regkomponentenbibliothek.ErdePort
import info.scce.cinco.product.cabo.kabelplan.kabelplan.Feld

public class PrimeRefREGHook extends CincoPostCreateHook<REG>{

	def override postCreate(REG reg) {
		val bpreg = reg.reg		
		
		reg.resize(bpreg.width, bpreg.height);
		
		for (port : bpreg.ports) {
			if (port instanceof PhasePort) {
				reg.newPhasePort(port.x, port.y, port.width, port.height)
			}
			else if (port instanceof NeutralPort) {
				reg.newNeutralPort(port.x, port.y, port.width, port.height)
			}
			else if (port instanceof ErdePort) {
				reg.newErdePort(port.x, port.y, port.width, port.height)
			}
		}
		
		val rightmostREG = (reg.container as Feld).REGs.filter[it != reg].filter[x < reg.x].sortBy[x].last 
		reg.y = 0
		reg.x = if (rightmostREG != null) rightmostREG.x + rightmostREG.width else 20
		
	}

}
