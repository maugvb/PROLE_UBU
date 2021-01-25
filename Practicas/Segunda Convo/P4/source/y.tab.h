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
     EQUAL = 258,
     COMPUTE = 259,
     MOVE = 260,
     TO = 261,
     IF = 262,
     THEN = 263,
     PARENTHESIS_START = 264,
     PARENTHESIS_END = 265,
     EVALUATE = 266,
     END_EVALUATE = 267,
     PERFORM = 268,
     WHEN = 269,
     UNTIL = 270,
     END_PERFORM = 271,
     DISPLAY = 272,
     ELSE = 273,
     END_IF = 274,
     ADD = 275,
     SUB = 276,
     MUL = 277,
     DIV = 278,
     NUME = 279,
     ID = 280
   };
#endif
/* Tokens.  */
#define EQUAL 258
#define COMPUTE 259
#define MOVE 260
#define TO 261
#define IF 262
#define THEN 263
#define PARENTHESIS_START 264
#define PARENTHESIS_END 265
#define EVALUATE 266
#define END_EVALUATE 267
#define PERFORM 268
#define WHEN 269
#define UNTIL 270
#define END_PERFORM 271
#define DISPLAY 272
#define ELSE 273
#define END_IF 274
#define ADD 275
#define SUB 276
#define MUL 277
#define DIV 278
#define NUME 279
#define ID 280




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 27 "1.y"
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

