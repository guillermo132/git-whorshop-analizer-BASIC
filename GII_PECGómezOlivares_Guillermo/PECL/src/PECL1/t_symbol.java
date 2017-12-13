package PECL1;

public class t_symbol {
	private String tipo;
    private String valor="";

    public t_symbol(String tipo) {
        this.tipo = tipo;
    }
    public t_symbol(String tipo, String valor) {
        this.tipo = tipo;
        this.valor = valor;
    }

    public String getTipo() {
        return tipo;
    }

    public String getValor() {
        return valor;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }
    

}
