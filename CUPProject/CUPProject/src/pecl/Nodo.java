package pecl;

import java.util.ArrayList;

public abstract class Nodo {
	    String nombre;
	    String tipo;
	    String valor;
	    ArrayList<Nodo> hijos;
	    int numHijos;
	    
	    public void limpiar(){
	    	hijos= new ArrayList<>();
	    	
	    	numHijos=0;
	    }
	    
	    
	    public int getNumHijos() {
	        return numHijos;
	    }

	    public void setNumHijos(int numHijos) {
	        this.numHijos = numHijos;
	    }
	    

	    public String getNombre() {
	        return nombre;
	    }

	    public String getTipo() {
	        return tipo;
	    }

	    public void setNombre(String nombre) {
	        this.nombre = nombre;
	    }

	    public void setTipo(String tipo) {
	        this.tipo = tipo;
	    }
	    
	   

	    public void setHijos(ArrayList<Nodo> hijos) {
	        this.hijos = hijos;
	    }

	    

	    public ArrayList<Nodo> getHijos() {
	        return hijos;
	    }

	    public String getValor() {
	        return valor;
	    }

	    public void setValor(String Valor) {
	        this.valor = Valor;
	    }
	    public void añadirHijo( Nodo n){
	        hijos.add(n);
	        numHijos++;
	    }    
	    @Override
	    public String toString() {
	        return "Nodo{" + "nombre=" + nombre + ", tipo=" + tipo + ", valor=" + valor + ", hijos=" + hijos + ", numHijos=" + numHijos + '}';
	    }
	    
	    
}
