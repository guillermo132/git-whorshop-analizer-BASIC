package pecl;

public class Simbolo {
	private String tipo;
    private Boolean valor=false;

    public Simbolo(String tipo) {
        this.tipo = tipo;
    }

    public String getTipo() {
        return tipo;
    }

    public boolean getValor() {
        return valor;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void inicializar() {
        this.valor = true;
    }
    
	
	
	
}
