10 DIM A(8), B(8,4)
15 DIM B(3)
20 DATA 3.15159, 24, 3,"hola", 3^-2, "adi9o"
30 INPUT "Hola", N
40 DEF FNX (B) = (N/B)+A
46 LET Z1 = 2
47 GOSUB 70
50 LET S$ = "A + 2"
65 READ J
70 GOTO 65
75 READ X,D,F$, G$, H$, M
80 IF A <> (D+N/B)+A THEN GOTO 50
90 RETURN
100 ON (A+B) GOTO 10,20,50
130 PRINT (A+B);"Hola", S$
190 END