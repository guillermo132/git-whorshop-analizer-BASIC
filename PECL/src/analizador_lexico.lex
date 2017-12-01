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
	//private static ArrayList<String> errorList = new ArrayList<String>();
	 
	/* Método de escribir en el fichero de salida y por pantalla*/
	private void writeOutputFile() throws IOException {
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

ERROR =(\~|\#|\@|\%|\~|\&|\\|\Ã¢|\Â¬|\$|\â‚¬|\âˆž)   
		
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
//EOF = "eof"
CRLF={CR}{LF}
Numero_Real      =   {Digito}\.{Digito}
expresion_num  =  (\+|\-)?([0-9]|{Digito}|{Numero_Real}|({Digito}|{Numero_Real})^(\+|\-)?{Digito}) 
constante = " "{expresion_num}
id_numerico ={Letra} "(" {Car_Cadena_Simple}{1,2}")"
id_cadena = {Letra}"$"
Identificador = {Digito} | {Letra}

%state estadoNumero

%%
"DATA" 				{this.tokensList.add(yytext());}
"DEF"				{this.tokensList.add(yytext());}
"DIM"				{this.tokensList.add(yytext());}
"END"				{this.tokensList.add(yytext());}
"FOR"				{this.tokensList.add(yytext());}
"GO"				{this.tokensList.add(yytext());}
"GOSUB" 			{this.tokensList.add(yytext());}
"GOTO" 				{this.tokensList.add(yytext());}
"IF" 				{this.tokensList.add(yytext());}
"INPUT" 			{this.tokensList.add(yytext());}
"LET" 				{this.tokensList.add(yytext());}
"NEXT" 				{this.tokensList.add(yytext());}
"ON" 				{this.tokensList.add(yytext());}
"PRINT" 			{this.tokensList.add(yytext());}
"RANDOMIZE" 		{this.tokensList.add(yytext());}
"READ" 				{this.tokensList.add(yytext());}
"REM" 				{this.tokensList.add(yytext());}
"RESTORE" 			{this.tokensList.add(yytext());}
"RETURN" 			{this.tokensList.add(yytext());}
"STEP" 				{this.tokensList.add(yytext());}
"STOP" 				{this.tokensList.add(yytext());}
"THEN" 				{this.tokensList.add(yytext());}
"TO" 				{this.tokensList.add(yytext());}
"ABS"				{this.tokensList.add(yytext());}
"ATN"				{this.tokensList.add(yytext());}
"COS"				{this.tokensList.add(yytext());}
"EXP"				{this.tokensList.add(yytext());}
"INT"				{this.tokensList.add(yytext());}
"LOG"				{this.tokensList.add(yytext());}
"RND"				{this.tokensList.add(yytext());}
"SGN"				{this.tokensList.add(yytext());}
"SQR"				{this.tokensList.add(yytext());}
"TAN"				{this.tokensList.add(yytext());}
"="					{this.tokensList.add("igual");}
"+"					{this.tokensList.add("mas");}
"-"					{this.tokensList.add("menos");}
"*"					{this.tokensList.add("mul");}
{Digito}			{this.tokensList.add("ent(" + yytext() + ")");}
{id_cadena}			{this.tokensList.add("ide(" + yytext() + ")");}
{id_numerico}		{this.tokensList.add("ide(" + yytext() + ")");}
{Identificador} 	{this.tokensList.add("id("+yytext()+")");}
{Cad_REM} 			{this.tokensList.add("CADENA REM: "+yytext());}
{Cad_Delimitada}	{this.tokensList.add("const(" + yytext().substring(1,yytext().length()-1) + ")");}
{CRLF}				{this.tokensList.add("CRLF");}
{CR}				{this.tokensList.add("CR");}
{LF}				{this.tokensList.add("LF");}
{PUNTOYCOMA} 		{this.tokensList.add("PUNTOYCOMA");}
{constante}			{this.tokensList.add("const(" + yytext().substring(1)+ ")");}

{ERROR} 	  		{System.out.println("Error lexico en linea " + (yyline+1) +  ": " + yytext() );}

<<EOF>>         {this.writeOutputFile(); System.exit(0);  /* Código ejecutado cuando se encuentra EOF */}  
.               {/* Regla léxica para evitar estrellarse cuando se encuentra algo extraño, no hacemos nada tampoco */}  
