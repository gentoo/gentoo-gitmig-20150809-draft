# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.4a-r5.ebuild,v 1.29 2004/11/12 15:51:55 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="GNU lexical analyser generator"
HOMEPAGE="http://lex.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="FLEX"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="build static"

DEPEND="virtual/libc"

S="${WORKDIR}/${P/a/}"

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

	use static && append-ldflags -static
	emake -j1 LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_test() {
	cd ${S}
	make bigcheck || die "Test phase failed"
}

src_install() {
	make -j1 prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		install || die "make install failed"

	if use build
	then
		rm -rf ${D}/usr/share ${D}/usr/include ${D}/usr/lib
	else
		dodoc NEWS README
	fi

	dosym flex /usr/bin/lex
}
