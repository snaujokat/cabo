package info.scce.cinco.product.cabo.hooks;

import de.jabc.cinco.meta.core.ge.style.model.customfeature.CincoPostCreateHook
import info.scce.cinco.product.cabo.api.ckabelplan.CBP_REG
import info.scce.cinco.product.cabo.api.ckabelplan.CErdePort
import info.scce.cinco.product.cabo.api.ckabelplan.CFeld
import info.scce.cinco.product.cabo.api.ckabelplan.CKabelPlan
import info.scce.cinco.product.cabo.api.ckabelplan.CNeutralPort
import info.scce.cinco.product.cabo.api.ckabelplan.CPhasePort
import info.scce.cinco.product.cabo.api.ckabelplan.CPort
import info.scce.cinco.product.cabo.api.ckabelplan.CREG
import info.scce.cinco.product.cabo.graphiti.KabelPlanWrapper
import info.scce.cinco.product.cabo.kabelplan.BP_REG
import info.scce.cinco.product.cabo.kabelplan.REG
import org.eclipse.graphiti.mm.pictograms.Diagram

public class PrimeRefREGHook extends CincoPostCreateHook<REG>{

	def override postCreate(REG reg) {
		val BP_REG bpreg = reg.reg
		val CKabelPlan bpcplan = KabelPlanWrapper.wrapGraphModel(bpreg.getRootElement(), bpreg.eResource().getContents().get(0) as Diagram)
		val CBP_REG cbpreg = bpcplan.findCBP_REG(bpreg)
		
		val CKabelPlan cplan = KabelPlanWrapper.wrapGraphModel(reg.getRootElement(), getDiagram());
		val CREG creg = cplan.findCREG(reg);
		
		creg.resize(cbpreg.width, cbpreg.height);
		
		
		for (CPort port : cbpreg.getCPorts()) {
			if (port instanceof CPhasePort) {
				creg.newCPhasePort(port.x, port.y, port.width, port.height)
			}
			else if (port instanceof CNeutralPort) {
				creg.newCNeutralPort(port.x, port.y, port.width, port.height)
			}
			else if (port instanceof CErdePort) {
				creg.newCErdePort(port.x, port.y, port.width, port.height)
			}
		}
		
		val rightmostREG = (creg.container as CFeld).CREGs.filter[it != creg].filter[x < creg.x].sortBy[x].last 
		creg.y = 0
		creg.x = if (rightmostREG != null) rightmostREG.x + rightmostREG.width else 20
		
	}

}
