package pecl;

import java.util.ArrayList;

public class NodoIntermedio extends Nodo{

    public NodoIntermedio(String nombre) {
        super.hijos= new ArrayList<>();
        super.tipo ="i";
        super.nombre=nombre;
        super.numHijos=0;
    }
    
    
    
}