# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/kawa/kawa-1.6.97.ebuild,v 1.9 2004/07/13 06:31:57 mr_bones_ Exp $

DESCRIPTION="Scheme compiler for JVM"
HOMEPAGE="http://www.gnu.org/software/kawa/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/kawa/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

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
