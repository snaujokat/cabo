package info.scce.cinco.product.cabo.hooks;

import info.scce.cinco.product.cabo.api.ckabelplan.CFeld
import info.scce.cinco.product.cabo.api.ckabelplan.CREG
import de.jabc.cinco.meta.core.ge.style.model.customfeature.CincoPostMoveHook
import graphicalgraphmodel.CModelElementContainer

public class REGPostMove extends CincoPostMoveHook<CREG> {
	
	override postMove(CREG creg, CModelElementContainer sourceContainer, CModelElementContainer targetContainer, int x, int y, int deltaX, int deltaY) {
		// the rightmost REG that is left of the moved REG
		val rightmostREG = (creg.container as CFeld).CREGs.filter[it != creg].filter[it.x < x].sortBy[it.x].last 
		
		// align moved REG directly next to rightmost REG
		// this was the initial implementation that did not feel right. let's see if the new one is better...
		// creg.x = if (rightmostREG != null) rightmostREG.x + rightmostREG.width else 20

		// vertical alignment is always the same
		creg.y = 0
		
		/*
		 * x < 20              20
		 * 20 <= x < 80        20 
		 * 60 <= x < 140       80
		 * 
		 */
		 
		 // round down to starting coordinate of full slot size (each slot is 60 pixels, with 20 pixels offset from left border)
		 val newX = if (creg.x < 20) 20 else (((x-20)/60)*60)+20
		 
		 if (rightmostREG != null) {
		 	// if rounded down x would be within rightmost REG, align moved REG directly next to rightmost REG (neglecting slot sizes)
		 	creg.x = if (newX < (rightmostREG.x + rightmostREG.width)) rightmostREG.x + rightmostREG.width else newX
		 }
		 else {
		 	// if no rightmost REG was found, use calculated coordinate as is
		 	creg.x = newX	
		 }
		 	
		 
		 
	}

}
