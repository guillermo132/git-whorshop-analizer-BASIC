package pecl;

public class Arbol {
	 private Nodo raiz;

	    public Arbol(Nodo raiz) {
	        this.raiz = raiz;
	    }

	    public void setRaiz(Nodo raiz) {
	        this.raiz = raiz;
	    }
	    
	    public String imprimirHijos(Nodo raiz, int a){
	     String s="";
	     for (int i = 0; i<raiz.numHijos;i++){
	        Nodo hijo=raiz.hijos.get(i);
	        if(hijo.getTipo().equals("i")){
	            s+="["+hijo.nombre+" ";
	            a++;
	            s+=this.imprimirHijos(hijo,a);
	            a--;
	            s+="]";
	            if(a==1) s+="\n";
	        }
	        else{
	        s+=""+hijo.nombre+" ("+hijo.valor+"), ";    
	            
	        }
	        
	       
	     }
	     
	     return s;   
	    }

	    
	    public String imprimir(){
	        Nodo r=this.raiz;
	        String s="";
	        s+=raiz.nombre+"(" ;
	        s+=this.imprimirHijos(raiz,1);
	        s+=")";
	        return s;
	    }

}
