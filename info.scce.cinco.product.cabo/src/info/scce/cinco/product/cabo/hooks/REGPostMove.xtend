package info.scce.cinco.product.cabo.hooks;

import info.scce.cinco.product.cabo.api.ckabelplan.CFeld
import info.scce.cinco.product.cabo.api.ckabelplan.CREG
import de.jabc.cinco.meta.core.ge.style.model.customfeature.CincoPostMoveHook
import graphicalgraphmodel.CModelElementContainer

public class REGPostMove extends CincoPostMoveHook<CREG> {
	
	override postMove(CREG creg, CModelElementContainer sourceContainer, CModelElementContainer targetContainer, int x, int y, int deltaX, int deltaY) {
		val rightmostREG = (creg.container as CFeld).CREGs.filter[it != creg].filter[it.x < x].sortBy[it.x].last 
		creg.y = 0
		creg.x = if (rightmostREG != null) rightmostREG.x + rightmostREG.width else 20
	}

}
