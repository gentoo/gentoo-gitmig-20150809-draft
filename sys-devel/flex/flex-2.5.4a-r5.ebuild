# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.4a-r5.ebuild,v 1.21 2004/07/15 03:13:24 agriffis Exp $

inherit eutils

S="${WORKDIR}/${P/a/}"
DESCRIPTION="GNU lexical analyser generator"
HOMEPAGE="http://lex.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="FLEX"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="build static"

DEPEND="virtual/libc"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Some Redhat patches to fix various problems
	epatch ${FILESDIR}/flex-2.5.4-glibc22.patch
	epatch ${FILESDIR}/flex-2.5.4a-gcc3.patch
	epatch ${FILESDIR}/flex-2.5.4a-gcc31.patch
	epatch ${FILESDIR}/flex-2.5.4a-skel.patch
}

src_compile() {
	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		|| die

	if ! use static
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

	if ! use build
	then
		dodoc NEWS README
	else
		rm -rf ${D}/usr/share ${D}/usr/include ${D}/usr/lib
	fi

	dosym flex /usr/bin/lex
}
