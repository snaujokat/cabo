package info.scce.cinco.product.cabo.hooks

import de.jabc.cinco.meta.runtime.action.CincoPostValueChangeListener
import info.scce.cinco.product.cabo.regs.regkomponentenbibliothek.BP_FREI

class REGResize extends CincoPostValueChangeListener<BP_FREI> {
	
	override canHandleChange(BP_FREI reg) {
		true
	}
	
	override handleChange(BP_FREI bpreg) {		
		bpreg.resize(bpreg.breite/3, 100)
	}
	
	
}