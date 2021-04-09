package info.scce.cinco.product.cabo.hooks

import info.scce.cinco.product.cabo.regs.regkomponentenbibliothek.BP_FREI
import de.jabc.cinco.meta.runtime.action.CincoPostAttributeChangeHook
import org.eclipse.emf.ecore.EStructuralFeature

class REGResize extends CincoPostAttributeChangeHook<BP_FREI> {
	
	override canHandleChange(BP_FREI reg,  EStructuralFeature changedAttribute) {
		true
	}
	
	override handleChange(BP_FREI bpreg, EStructuralFeature changedAttribute) {		
		bpreg.resize(bpreg.breite/3, 100)
	}
	
	
}