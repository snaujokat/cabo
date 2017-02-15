package info.scce.cinco.product.cabo.primeviewer.regs;
import org.eclipse.core.resources.IFile;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.jface.viewers.ITreeContentProvider;
import org.eclipse.jface.viewers.Viewer;
import  org.eclipse.emf.common.util.EList;
import java.util.ArrayList;
import org.eclipse.emf.common.util.TreeIterator;

public class BP_REGContentProvider implements ITreeContentProvider{

	private Viewer viewer;

	@Override
	public void dispose() {
		
	}

	@Override
	public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
		this.viewer = viewer;
		
	}

	@Override
	public Object[] getElements(Object inputElement) {
		return null;
	}

	@Override
	public Object[] getChildren(Object parentElement) {
		try{
		if(parentElement instanceof IFile){
		IFile file = (IFile) parentElement;
		if(file.getName().endsWith("regs")){
			URI fileURI = URI.createPlatformResourceURI(file.getFullPath().toString(), true) ;
			EObject prime = null;
			Resource resource = new ResourceSetImpl().getResource(fileURI, true);
		ArrayList<EObject> eObjList = new ArrayList<>();
		TreeIterator<EObject> x = resource.getAllContents();
		while(x.hasNext()){
			EObject o = x.next();
            if((o.eClass().getName().equals("BP_REG")||o.eClass().getEAllSuperTypes().stream().anyMatch(e -> e.getName().equals("BP_REG")) )&& o.eClass().getEPackage().getNsPrefix().equals("regkomponentenbibliothek")){
	        		prime = o;
	        		eObjList.add(o);
	        	}
	        		
	        }
	        if(prime==null)
	        	return null;
	        
	        return eObjList.toArray();
	        
		}
		return null;
		}
		return null;
		}catch(Exception e){
			return null;		
		}
	}

	@Override
	public Object getParent(Object element) {

		return null;
	}

	@Override
	public boolean hasChildren(Object element) {
		try{
		if(element instanceof IFile){
		IFile file = (IFile) element;
		if(file.getName().endsWith("regs")){
			URI fileURI = URI.createPlatformResourceURI(file.getFullPath().toString(), true) ;
			Resource resource = new ResourceSetImpl().getResource(fileURI, true);	        
			return resource.getContents().size()>=1;
		}
		return false;
	}
	}catch(Exception e){return false;}
	
	return false;
	}
}
