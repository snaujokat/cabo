package info.scce.cinco.product.cabo.hooks

import de.jabc.cinco.meta.runtime.action.CincoPostValueChangeListener
import info.scce.cinco.product.cabo.regs.graphiti.REGKomponentenBibliothekWrapper
import info.scce.cinco.product.cabo.regs.regkomponentenbibliothek.BP_FREI
import org.eclipse.graphiti.mm.pictograms.Diagram

class REGResize extends CincoPostValueChangeListener<BP_FREI> {
	
	override canHandleChange(BP_FREI reg) {
		true
	}
	
	override handleChange(BP_FREI bpreg) {
		val bpcplan = REGKomponentenBibliothekWrapper.wrapGraphModel(bpreg.getRootElement(), bpreg.eResource().getContents().get(0) as Diagram)
		val cbpreg = bpcplan.findCBP_FREI(bpreg)
		cbpreg.resize(bpreg.breite/3, 100)
	}
	
	
}