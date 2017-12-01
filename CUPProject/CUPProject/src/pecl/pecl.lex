package pecl;


import java.util.*;
import java.io.*;
import java_cup.runtime.*;
//Bloque de configuracion analizador
%%
%cup
%integer
%line
%column
%unicode
%ignorecase
%full

//Bloque de java
%{

private ArrayList<String> tokens = new ArrayList<>();
int err=0;
public int getErr(){
	return err;
}
public String imprimir() throws IOException {
	String s="\n[";
	Iterator<String> itr = tokens.iterator();
	int cont=0;
	while (itr.hasNext()) {
		cont++;
		s=s+itr.next();
		if(itr.hasNext()){
			s=s+", ";
			if(cont%5==0){
				s=s+"\n";
			}
		}
	}
	s=s+"]";
	return s;
}
%}
//Reglas lexicograficas y MACROS
Integer     = [0-9]+                // Macro para numeros enteros sin signo
Identifier  = [a-zA-Z][a-zA-Z0-9_]*  // Macro para identificadores 
ErrorAsign1 = [a-zA-Z0-9_]*[^a-zA-Z0-9_\n\r\t><= ;,.:()/*+-]*[a-zA-Z0-9_]* // Carácter no permitido
//Reglas y acciones 

%%
// palabras reservadas
"program" {this.tokens.add(yytext()); return new Symbol(PeclSym.PROGRAM, yyline, yycolumn, yytext());}
"is"     {this.tokens.add(yytext()); return new Symbol(PeclSym.IS, yyline, yycolumn, yytext());}
"begin"   {this.tokens.add(yytext()); return new Symbol(PeclSym.BEGIN, yyline, yycolumn, yytext());}
"end"     {this.tokens.add(yytext()); return new Symbol(PeclSym.END, yyline, yycolumn, yytext());}
"var"     {this.tokens.add(yytext()); return new Symbol(PeclSym.VAR, yyline, yycolumn, yytext());}
"integer" {this.tokens.add(yytext()); return new Symbol(PeclSym.INTEGER, yyline, yycolumn, yytext());}
"boolean" {this.tokens.add(yytext()); return new Symbol(PeclSym.BOOLEAN, yyline, yycolumn, yytext());}
"read"    {this.tokens.add(yytext()); return new Symbol(PeclSym.READ, yyline, yycolumn, yytext());}
"write"   {this.tokens.add(yytext()); return new Symbol(PeclSym.WRITE, yyline, yycolumn, yytext());}
"skip"    {this.tokens.add(yytext()); return new Symbol(PeclSym.SKIP, yyline, yycolumn, yytext());}
"while"   {this.tokens.add(yytext()); return new Symbol(PeclSym.WHILE, yyline, yycolumn, yytext());}
"do"      {this.tokens.add(yytext()); return new Symbol(PeclSym.DO, yyline, yycolumn, yytext());}
"if"      {this.tokens.add(yytext()); return new Symbol(PeclSym.IF, yyline, yycolumn, yytext());}
"then"    {this.tokens.add(yytext()); return new Symbol(PeclSym.THEN, yyline, yycolumn, yytext());}
"else"    {this.tokens.add(yytext()); return new Symbol(PeclSym.ELSE, yyline, yycolumn, yytext());}
"and"     {this.tokens.add(yytext()); return new Symbol(PeclSym.AND, yyline, yycolumn, yytext());}
"or"      {this.tokens.add(yytext()); return new Symbol(PeclSym.OR, yyline, yycolumn, yytext());}
"true"    {this.tokens.add(yytext()); return new Symbol(PeclSym.TRUE, yyline, yycolumn, yytext());}
"false"   {this.tokens.add(yytext()); return new Symbol(PeclSym.FALSE, yyline, yycolumn, yytext());}
"not"     {this.tokens.add(yytext()); return new Symbol(PeclSym.NOT, yyline, yycolumn, yytext());}

":="  {this.tokens.add("asign"); return new Symbol(PeclSym.ASIGNACION, yyline, yycolumn, yytext());}
"<=" {this.tokens.add("comp"); return new Symbol(PeclSym.MENOR_IGUAL, yyline, yycolumn, yytext());}
"<"  {this.tokens.add("comp"); return new Symbol(PeclSym.MENOR, yyline, yycolumn, yytext());}
"="  {this.tokens.add("comp"); return new Symbol(PeclSym.IGUAL, yyline, yycolumn, yytext());}
">"  {this.tokens.add("comp"); return new Symbol(PeclSym.MAYOR, yyline, yycolumn, yytext());}
">=" {this.tokens.add("comp"); return new Symbol(PeclSym.MAYOR_IGUAL, yyline, yycolumn, yytext());}
"<>" {this.tokens.add("comp"); return new Symbol(PeclSym.DISTINTO, yyline, yycolumn, yytext());}

"+"	      {this.tokens.add("mas"); return new Symbol(PeclSym.SUMA, yyline, yycolumn, yytext());}
"-"	      {this.tokens.add("menos"); return new Symbol(PeclSym.RESTA, yyline, yycolumn, yytext());}
"*"	      {this.tokens.add("mul"); return new Symbol(PeclSym.MULTIPLICACION, yyline, yycolumn, yytext());}
"/"	      {this.tokens.add("div"); return new Symbol(PeclSym.DIVISION, yyline, yycolumn, yytext());}

"("	      {this.tokens.add("paren_izq"); return new Symbol(PeclSym.PARENT_IZQ, yyline, yycolumn, yytext());}
")"	      {this.tokens.add("paren_der"); return new Symbol(PeclSym.PARENT_DER, yyline, yycolumn, yytext());}
","	      {this.tokens.add("coma"); return new Symbol(PeclSym.COMA, yyline, yycolumn, yytext());}
";"	      {this.tokens.add("punto_coma"); return new Symbol(PeclSym.PUNTO_COMA, yyline, yycolumn, yytext());}
":"	      {this.tokens.add("dos_puntos"); return new Symbol(PeclSym.DOS_PUNTOS, yyline, yycolumn, yytext()); }


{Integer} 	 {this.tokens.add("num "+ "("+yytext()+")"); return new Symbol(PeclSym.NUM, yyline, yycolumn, yytext());}
{Identifier} {this.tokens.add("ide "+ "("+yytext()+")"); return new Symbol(PeclSym.IDE, yyline, yycolumn, yytext());}
{ErrorAsign1} {System.err.println("Asignador incorrecto en linea: "+ (yyline+1)+ " columna:"+(yycolumn+1) +" Carácter: "+yytext() );System.out.println();err++;}
\t\r|\n|\r\n|\u2028|\u2029|\u000B|\u000C|\u0085 { }
<<EOF>>         {return new Symbol(PeclSym.EOF); }
. {}
