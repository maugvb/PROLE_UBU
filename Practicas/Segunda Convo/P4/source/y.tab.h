/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     PARENTHESIS_START = 258,
     PARENTHESIS_END = 259,
     ARROW = 260,
     DIV = 261,
     MUL = 262,
     SUB = 263,
     ADD = 264,
     SEMICOL = 265,
     PRINT = 266,
     END = 267,
     BEGINTK = 268,
     STEP = 269,
     TO = 270,
     FROM = 271,
     FOR = 272,
     DO = 273,
     WHILE = 274,
     ELSE = 275,
     ENDIF = 276,
     THEN = 277,
     IF = 278,
     NUME = 279,
     ID = 280
   };
#endif
/* Tokens.  */
#define PARENTHESIS_START 258
#define PARENTHESIS_END 259
#define ARROW 260
#define DIV 261
#define MUL 262
#define SUB 263
#define ADD 264
#define SEMICOL 265
#define PRINT 266
#define END 267
#define BEGINTK 268
#define STEP 269
#define TO 270
#define FROM 271
#define FOR 272
#define DO 273
#define WHILE 274
#define ELSE 275
#define ENDIF 276
#define THEN 277
#define IF 278
#define NUME 279
#define ID 280




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 23 "1.y"
{
    int value;
    char *string;
    struct LabelPayload *payload;
}
/* Line 1529 of yacc.c.  */
#line 105 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

