# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.4a-r5.ebuild,v 1.10 2003/04/17 22:53:29 mholzer Exp $

S="${WORKDIR}/${P/a/}"
DESCRIPTION="GNU lexical analyser generator"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/flex/flex.html"

LICENSE="FLEX"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Some Redhat patches to fix various problems
	patch -p1 < ${FILESDIR}/flex-2.5.4-glibc22.patch || die
	patch -p1 < ${FILESDIR}/flex-2.5.4a-gcc3.patch || die
	patch -p1 < ${FILESDIR}/flex-2.5.4a-gcc31.patch || die
	patch -p1 < ${FILESDIR}/flex-2.5.4a-skel.patch || die
}

src_compile() {
	./configure --prefix=/usr \
		--host=${CHOST} || die

	if [ -z "`use static`" ]
	then
		emake || make || die
	else
		emake LDFLAGS=-static || die
	fi
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		install || die
	
	if [ -z "`use build`" ]
	then
		dodoc COPYING NEWS README
	else
		rm -rf ${D}/usr/share ${D}/usr/include ${D}/usr/lib
	fi

	dosym flex /usr/bin/lex
}

