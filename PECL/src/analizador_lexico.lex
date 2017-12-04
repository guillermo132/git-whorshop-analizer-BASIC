package PECL1;

import java_cup.runtime.*;
import java.io.*;
import java.util.*;
import java.util.ArrayList;

// import PECL1.Analizador_LexicoSym;
// import static PECL1.Analizador_LexicoSym.*;

%%

%class Analizador_LexicoLex
%unicode
%line
%column
%standalone
%cup

%init{

	this.tokensList = new ArrayList();
   // this.errorList = new ArrayList();
    
%init}

%{
	private static ArrayList<String> tokensList = new ArrayList<String>();
	int err=0;
	public int getErr(){
		return err;
	}
	//private static ArrayList<String> errorList = new ArrayList<String>();
	 
	/* M�todo de escribir en el fichero de salida y por pantalla*/
	public void writeOutputFile() throws IOException {
		String filename = "file.out";
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
Car_Cadena_Simple = "+" | "-" | "." | {Digito} | {Letra}
Cad_REM	="'"{Car_cadena}*
Cad_Delimitada=\"{Car_Cad_Delimitado}*\"
//Cad_No_Delimitada = {Car_Cadena_Simple} | {Car_Cadena_Simple} {Car_No_Delimitado}* {Car_Cadena_Simple}

LF	= 	\n
CR	=	\r

CRLF={CR}{LF}
Numero_Real      =   {Digito}\.{Digito}
expresion_num  =  (\+|\-)?([0-9]|{Digito}|{Numero_Real}|({Digito}|{Numero_Real})\^(\+|\-)?{Digito}) 
constante = " "{expresion_num}
id_numerico ={Letra} "(" {Car_Cadena_Simple} (","{Car_Cadena_Simple})*")"
id_cadena = {Letra}"$"
Identificador = {Digito} | {Letra}
funcion = FN{Letra} | FN{Letra}" ""("{Letra}")"

funcionMat = "ABS" | "ATN" | "COS" | "EXP" | "INT" | "LOG" | "RND" | "SGN" | "SQR" | "TAN";

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
"REM" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.REM,yyline,yycolumn);}
"RESTORE" 			{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.RESTORE,yyline,yycolumn);}
"RETURN" 			{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.RETURN,yyline,yycolumn);}
"STEP" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.STEP,yyline,yycolumn);}
"STOP" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.STOP,yyline,yycolumn);}
"THEN" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.THEN,yyline,yycolumn);}
"TO" 				{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.TO,yyline,yycolumn);}
{funcionMat}		{this.tokensList.add(yytext()); return new Symbol(Analizador_SintacticoSym.FUNCION_MAT,yyline,yycolumn, yytext());}
"="					{this.tokensList.add("igual");  return new Symbol(Analizador_SintacticoSym.IGUAL,yyline,yycolumn);}
"+"					{this.tokensList.add("mas");    return new Symbol(Analizador_SintacticoSym.MAS,yyline,yycolumn);}
"-"					{this.tokensList.add("menos");  return new Symbol(Analizador_SintacticoSym.MENOS,yyline,yycolumn);}
"*"					{this.tokensList.add("mul");    return new Symbol(Analizador_SintacticoSym.MUL,yyline,yycolumn);}
"/"					{this.tokensList.add("div");    return new Symbol(Analizador_SintacticoSym.DIVISION,yyline,yycolumn);}
"^"					{this.tokensList.add("exp");    return new Symbol(Analizador_SintacticoSym.EXPONENTE,yyline,yycolumn);}
"("					{this.tokensList.add("PARENTESIS_IZQ");return new Symbol(Analizador_SintacticoSym.PARENTESIS_IZQ,yyline,yycolumn);}
")"					{this.tokensList.add("PARENTESIS_DER");return new Symbol(Analizador_SintacticoSym.PARENTESIS_DER,yyline,yycolumn);}
{Digito}			{this.tokensList.add("ent(" + yytext() + ")"); return new Symbol(Analizador_SintacticoSym.ENTERO,yyline,yycolumn, yytext());}
{id_cadena}			{this.tokensList.add("ide(" + yytext() + ")"); return new Symbol(Analizador_SintacticoSym.IDE,yyline,yycolumn, yytext());}
{id_numerico}		{this.tokensList.add("ide(" + yytext() + ")"); return new Symbol(Analizador_SintacticoSym.IDE_NUM,yyline,yycolumn, yytext());}
{Identificador} 	{this.tokensList.add("id("+yytext()+")");      return new Symbol(Analizador_SintacticoSym.ID,yyline,yycolumn, yytext());}
{Cad_REM} 			{this.tokensList.add("CADENA REM: "+yytext()); return new Symbol(Analizador_SintacticoSym.REM,yyline,yycolumn, yytext());}
{Cad_Delimitada}	{
						this.tokensList.add("const(" + yytext().substring(1,yytext().length()-1) + ")");
						return new Symbol(Analizador_SintacticoSym.CONSTANTE,yyline,yycolumn, yytext().substring(1,yytext().length()-1)); 
					}
{CRLF}				{this.tokensList.add("CRLF"); return new Symbol(Analizador_SintacticoSym.CRLF,yyline,yycolumn);}
{CR}				{this.tokensList.add("CR");   return new Symbol(Analizador_SintacticoSym.CR,yyline,yycolumn);}
{LF}				{this.tokensList.add("LF");   return new Symbol(Analizador_SintacticoSym.LF,yyline,yycolumn);}
{PUNTOYCOMA} 		{
 						this.tokensList.add("PUNTOYCOMA");
 						return new Symbol(Analizador_SintacticoSym.PUNTOYCOMA,yyline,yycolumn); 
 					}
{constante}			{
						this.tokensList.add("const(" + yytext().substring(1)+ ")");
						return new Symbol(Analizador_SintacticoSym.CONSTANTE_NUM,yyline,yycolumn, yytext().substring(1));
					}
					
{funcion}			{	this.tokensList.add(yytext());
 						return new Symbol(Analizador_SintacticoSym.FUNCION,yyline,yycolumn, yytext()); 
					}

{ERROR} 	  		{System.err.println("Error lexico en linea " + (yyline+1) +  ": " + yytext() );System.out.println();err++;}

<<EOF>>         {this.writeOutputFile(); return new Symbol(Analizador_SintacticoSym.EOF,yyline,yycolumn);}  
.               {/* Regla l�xica para evitar estrellarse cuando se encuentra algo extra�o, no hacemos nada tampoco */}  
