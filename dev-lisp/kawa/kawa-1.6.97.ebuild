# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/kawa/kawa-1.6.97.ebuild,v 1.1 2002/02/17 19:41:47 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scheme compiler for JVM"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/kawa/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/kawa/"

DEPEND="virtual/jdk"
RDEPEND="virtual/jre"

src_compile() {
	export PATH=${PATH}:${JDK_HOME}/bin 
	which javac
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	mv ${D}/usr/share/java ${D}/usr/share/kawa

	exeinto usr/bin
	newexe ${FILESDIR}/kawa-1.6.97.sh kawa

	dodoc COPYING TODO README NEWS
	doinfo doc/kawa.info*
	dohtml doc/*less 
}
