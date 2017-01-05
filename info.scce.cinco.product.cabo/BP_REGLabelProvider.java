package info.scce.cinco.product.cabo.primeviewer.kabelplan;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IWorkspace;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.Path;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.viewers.ILabelProvider;
import org.eclipse.jface.viewers.ILabelProviderListener;
import org.eclipse.swt.graphics.Image;


public class BP_REGLabelProvider implements ILabelProvider {

	@Override
	public void addListener(ILabelProviderListener listener) {

	}

	@Override
	public void dispose() {

	}

	@Override
	public boolean isLabelProperty(Object element, String property) {
		return false;
	}

	@Override
	public void removeListener(ILabelProviderListener listener) {

	}

	@Override
	public Image getImage(Object element) {
		if(element instanceof EObject){
			EObject eElement = (EObject) element;
			if(eElement.eClass().getName().equals("BP_REG")){
				EStructuralFeature cincoImagePathFeature = eElement.eClass().getEStructuralFeature("cincoImagePath");
				if(cincoImagePathFeature!=null){
					Object imagePath= eElement.eGet(cincoImagePathFeature);
					ImageDescriptor imgDescriptor = null;
					try {
                        IProject pr = getProject(eElement.eResource());
						IFile imageFile = pr.getFile(imagePath.toString());
						if(imageFile!=null && imageFile.exists())
							imgDescriptor = ImageDescriptor.createFromURL(imageFile.getLocationURI().toURL());
						
						
						Image img= null;
						if(imgDescriptor!=null){
							img= imgDescriptor.createImage();
							
						}
						if(img!=null){
							return ImageDescriptor.createFromImageData(img.getImageData().scaledTo(16, 16)).createImage();
						}else{
							imgDescriptor = ImageDescriptor.createFromURL(new URI("file://"+imagePath.toString()).toURL());
							if(imgDescriptor!=null)
								img= imgDescriptor.createImage();
							if(img!=null)
								return ImageDescriptor.createFromImageData(img.getImageData().scaledTo(16, 16)).createImage();
						}
						
						
						return ImageDescriptor.createFromImageData(img.getImageData().scaledTo(16, 16)).createImage();
					} catch (MalformedURLException e) {
						e.printStackTrace();
					} catch (URISyntaxException e) {
						e.printStackTrace();
					}
					
					
					
				}
			}
		}
			return null;
	}

	@Override
	public String getText(Object element) {
		if(element instanceof EObject){
			EObject eElement = (EObject) element;
			if((eElement.eClass().getName().equals("BP_REG")||eElement.eClass().getEAllSuperTypes().stream().anyMatch(e -> e.getName().equals("BP_REG"))))
				return eElement.eGet(eElement.eClass().getEStructuralFeature("short_descr")).toString();
		}
			return null;
		
	}

private IProject getProject(Resource res){
		IWorkspace workspace = ResourcesPlugin.getWorkspace();
		org.eclipse.emf.common.util.URI uri = res.getURI();
		if(uri.isPlatformResource()){
			IFile iFile = workspace.getRoot().getFile(new Path(uri.toPlatformString(true)));
			return iFile.getProject();
		}
		return null;
	}


}
