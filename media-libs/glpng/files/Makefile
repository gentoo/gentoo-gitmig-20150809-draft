# New ports collection makefile for:	glpng
# Date created:		06 Mar 2006
# Whom:			Dmitry Marakasov <amdmi3@amdmi3.ru>
#
# $FreeBSD: ports/graphics/glpng/Makefile,v 1.6 2008/06/19 17:28:19 amdmi3 Exp $
#

LIB_DEPENDS=	/usr/lib/libpng.so

AR?=		/usr/bin/ar
LN?=		/bin/ln
INSTALL_DATA?=	/bin/cp
MKDIR?=		/bin/mkdir
DESTDIR?=	/
PREFIX=		${DESTDIR}/usr
WRKSRC=		/src
LOCALBASE= ./
LD = /usr/bin/ld
all:
	${CC} ${CFLAGS} -fPIC -I${LOCALBASE}/include -c -o ${WRKSRC}/libglpng.o ${LDFLAGS} ${WRKSRC}/glpng.c
	${CC} ${CFLAGS} -L${LOCALBASE}/lib -shared -soname -lGL -lpng -lz -lm -o ${WRKSRC}/libglpng.so.1 ${LDFLAGS},-soname=libglpng.so.1 ${WRKSRC}/libglpng.o
	${AR} cqs ${WRKSRC}/libglpng.a ${WRKSRC}/libglpng.o

install:
	${MKDIR} -p ${PREFIX}/lib
	${INSTALL_DATA} ${WRKSRC}/libglpng.so.1 ${PREFIX}/lib
	${INSTALL_DATA} ${WRKSRC}/libglpng.a ${PREFIX}/lib
	${LN} -sf libglpng.so.1 ${PREFIX}/lib/libglpng.so
	${MKDIR} -p ${PREFIX}/include/GL/
	${INSTALL_DATA} include/GL/glpng.h ${PREFIX}/include/GL/
