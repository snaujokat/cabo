package info.scce.cinco.product.cabo.hooks;

import info.scce.cinco.product.cabo.kabelplan.kabelplan.REG
import graphmodel.ModelElementContainer
import de.jabc.cinco.meta.runtime.hook.CincoPostMoveHook
import info.scce.cinco.product.cabo.kabelplan.kabelplan.Feld

public class REGPostMove extends CincoPostMoveHook<REG> {
	
	override postMove(REG creg, ModelElementContainer sourceContainer, ModelElementContainer targetContainer, int x, int y, int deltaX, int deltaY) {
		// the rightmost REG that is left of the moved REG
		val rightmostREG = (creg.container as Feld).REGs.filter[it != creg].filter[it.x < x].sortBy[it.x].last 
		
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
