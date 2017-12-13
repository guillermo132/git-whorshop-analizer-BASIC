package PECL1;

import java_cup.runtime.*;
import java.io.*;
import java.util.*;
import java.util.ArrayList;

%%

%class Analizador_LexicoLex //Definicion de nombre de la clase java
%unicode
%line						// Detector de lineas
%column						// Detector de columnas
%standalone
%cup						//Enlazador con CUP


%init{
	this.tokensList = new ArrayList();
%init}

//Codigo
%{
	private static ArrayList<String> tokensList = new ArrayList<String>();
	int err=0;

	public int getErr(){
		return err;
	}
	/* Metodo de escribir en el fichero de salida y por pantalla*/
	public void writeOutputFile() throws IOException {
		String filename = "salida.out";
		BufferedWriter out = new BufferedWriter(new FileWriter(filename));
		System.out.print("[");
 		out.write("[");
		
		for (String s : this.tokensList) {
			if(s=="CRLF" || s=="LF"){
		 		System.out.print(s+",\n");
		 		out.write(s + ",\n");
		 	}
		 	else{
			 	System.out.print(s+",");
			 	out.write(s + ",");
			 }
	 	} 
	 	System.out.print("EOF]");
 		out.write("EOF]");
	 	out.close();
	}

%}

// *****************************************	Definiciones Macros	   *****************************************

ERROR =(\~|\#|\@|\%|\~|\&|\\|\â|\¬|\$|\€|\∞)   
		
PUNTOYCOMA = ";"							  		//Signos de puntuacion 

Letra = [a-zA-Z]
Digito = [0-9]+
Car_cadena = [\"] | {Car_Cad_Delimitado}
Car_Cad_Delimitado	=	"!" | "#" | "$" | "%" | "&" | "'" | 
						"(" | ")" | "*" | "," | "/" | ":" |
						";" | "<" | "=" | ">" | "?" | "^" |
						"_" | {Car_No_Delimitado}
					 
Car_No_Delimitado = " " | {Car_Cadena_Simple}					 
Car_Cadena_Simple = "^" | "+" | "-" | "." | "," | "/" | "*" | {Digito} | {Letra}

Cad_REM = REM {value_coment}* | "'" {value_coment}* | "'" {Car_cadena}*
value_coment = ERROR| "*" | "/" | "+" | "-" | "," |{funcionMat}|{expresion_num}|" "|{Letra}|{Digito}

Cad_Delimitada=\"{Car_Cad_Delimitado}*\"
//Cad_No_Delimitada = {Car_Cadena_Simple} | {Car_Cadena_Simple} {Car_No_Delimitado}* {Car_Cadena_Simple}

LF	= 	\n
CR	=	\r

Operadores = "+" | "-" | "*" | "/" | "^";

CRLF={CR}{LF}
num_entero = (\+|\-)?{Digito}
num_real = (\+|\-)?{Digito}[\.]{Digito}
numero_escalada = (\+|\-)?{Digito}[\^](\+|\-)?{Digito}
operacion = (\+|\-)?{Digito}{Operadores}(\+|\-)?{Digito}({Operadores}(\+|\-)?({Digito}|{Letra}))*
expresion_num = {num_entero}|{num_real}|{numero_escalada}|{operacion}
constante = " "{expresion_num}
id_numerico_sus ={Letra} "(" {Car_Cadena_Simple}+ ")"
id_cadena = {Letra}"$"
Identificador = {Letra}{Digito}?
funcion = FN{Letra} | FN{Letra}" ""("{Letra}")" | FN{Letra}"("{Letra}")"

funcionMat = "ABS" | "ATN" | "COS" | "EXP" | "INT" | "LOG" | "SGN" | "SQR" | "TAN";

%state estadoNumero

%%
"DATA" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.DATA,yyline,yycolumn);}
"DEF"				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.DEF,yyline,yycolumn);}
"DIM"				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.DIM,yyline,yycolumn);}
"END"				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.END,yyline,yycolumn);}
"FOR"				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.FOR,yyline,yycolumn);}
"GO"				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.GO,yyline,yycolumn);}
"GOSUB" 			{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.GOSUB,yyline,yycolumn);}
"GOTO" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.GOTO,yyline,yycolumn);}
"IF" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.IF,yyline,yycolumn);}
"INPUT" 			{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.INPUT,yyline,yycolumn);}
"LET" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.LET,yyline,yycolumn);}
"NEXT" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.NEXT,yyline,yycolumn);}
"ON" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.ON,yyline,yycolumn);}
"PRINT" 			{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.PRINT,yyline,yycolumn);}
"RANDOMIZE" 		{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.RANDOMIZE,yyline,yycolumn);}
"READ" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.READ,yyline,yycolumn);}
"RESTORE" 			{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.RESTORE,yyline,yycolumn);}
"RETURN" 			{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.RETURN,yyline,yycolumn);}
"STEP" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.STEP,yyline,yycolumn);}
"STOP" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.STOP,yyline,yycolumn);}
"THEN" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.THEN,yyline,yycolumn);}
"TO" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.TO,yyline,yycolumn);}
"RND"				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.RND,yyline,yycolumn);}
{funcionMat}		{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.FUNCION_MAT,yyline,yycolumn, yytext());}
"="					{this.tokensList.add("igual");  return new Symbol(Analizador_SintacticoSym.IGUAL,yyline,yycolumn);}
"+"					{this.tokensList.add("mas");    return new Symbol(Analizador_SintacticoSym.MAS,yyline,yycolumn);}
"-"					{this.tokensList.add("menos");  return new Symbol(Analizador_SintacticoSym.MENOS,yyline,yycolumn);}
"*"					{this.tokensList.add("mul");    return new Symbol(Analizador_SintacticoSym.MUL,yyline,yycolumn);}
"/"					{this.tokensList.add("div");    return new Symbol(Analizador_SintacticoSym.DIVISION,yyline,yycolumn);}
"^"					{this.tokensList.add("exp");    return new Symbol(Analizador_SintacticoSym.EXPONENTE,yyline,yycolumn);}
"("					{this.tokensList.add("PARENTESIS_IZQ");return new Symbol(Analizador_SintacticoSym.PARENTESIS_IZQ,yyline,yycolumn);}
")"					{this.tokensList.add("PARENTESIS_DER");return new Symbol(Analizador_SintacticoSym.PARENTESIS_DER,yyline,yycolumn);}
","					{this.tokensList.add("coma");return new Symbol(Analizador_SintacticoSym.COMA,yyline,yycolumn);}
"<="				{this.tokensList.add("menor_igual");  return new Symbol(Analizador_SintacticoSym.MENOR_IGUAL,yyline,yycolumn);}
"=>"				{this.tokensList.add("mayor_igual");  return new Symbol(Analizador_SintacticoSym.MAYOR_IGUAL,yyline,yycolumn);}
"<"					{this.tokensList.add("menor");  return new Symbol(Analizador_SintacticoSym.MENOR,yyline,yycolumn);}
">"					{this.tokensList.add("mayor");  return new Symbol(Analizador_SintacticoSym.MAYOR,yyline,yycolumn);}
"<>"				{this.tokensList.add("distinto");  return new Symbol(Analizador_SintacticoSym.DISTINTO,yyline,yycolumn);}
{Digito}			{this.tokensList.add("ent(" + yytext() + ")"); return new Symbol(Analizador_SintacticoSym.ENTERO,yyline,yycolumn, yytext());}
{id_cadena}			{this.tokensList.add("ide(" + yytext() + ")"); return new Symbol(Analizador_SintacticoSym.ID_CADENA,yyline,yycolumn, yytext());}
{id_numerico_sus}	{this.tokensList.add("ide(" + yytext() + ")"); return new Symbol(Analizador_SintacticoSym.ID_NUM_SUS,yyline,yycolumn, yytext());}
{Identificador} 	{this.tokensList.add("id("+yytext()+")");  return new Symbol(Analizador_SintacticoSym.ID_NUM,yyline,yycolumn, yytext());}
{Cad_REM} 			{this.tokensList.add("value_coment: "+yytext()); return new Symbol(Analizador_SintacticoSym.REM,yyline,yycolumn, yytext());}
{Cad_Delimitada}	{
						this.tokensList.add("const(" + yytext().substring(1,yytext().length()-1) + ")");
						return new Symbol(Analizador_SintacticoSym.CONSTANTE,yyline,yycolumn, yytext().substring(1,yytext().length()-1)); 
					}
{CRLF}				{this.tokensList.add("CRLF"); return new Symbol(Analizador_SintacticoSym.CRLF,yyline,yycolumn);}
{CR}				{this.tokensList.add("CR");}
{LF}				{this.tokensList.add("LF");}
{PUNTOYCOMA} 		{
 						this.tokensList.add("PUNTOYCOMA");
 						return new Symbol(Analizador_SintacticoSym.PUNTOYCOMA,yyline,yycolumn); 
 					}
{constante}			{
						this.tokensList.add("const_num(" + yytext().substring(1)+ ")");
						return new Symbol(Analizador_SintacticoSym.CONSTANTE_NUM,yyline,yycolumn, yytext().substring(1));
					}
					
{funcion}			{	this.tokensList.add(yytext());
 						return new Symbol(Analizador_SintacticoSym.FUNCION,yyline,yycolumn, yytext()); 
					}

{ERROR} 	  		{System.err.println("Error lexico en linea " + (yyline+1) +  " columna " + (yycolumn+1) +": " + yytext() );err++;}

<<EOF>>         {/*System.out.println("Numero de errores: "+this.getErr()); this.writeOutputFile(); */return new Symbol(Analizador_SintacticoSym.EOF,yyline,yycolumn);}  
.               {/* */}  
