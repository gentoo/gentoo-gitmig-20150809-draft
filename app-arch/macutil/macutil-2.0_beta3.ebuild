# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/macutil/macutil-2.0_beta3.ebuild,v 1.1 2004/06/02 21:27:33 dholm Exp $

inherit eutils

S="${WORKDIR}/${PN}"
MY_P=${P/_beta/b}
DESCRIPTION="A collection of programs to handle Macintosh files/archives on non-Macintosh systems"
SRC_URI="ftp://ftp.cwi.nl/pub/dik/${MY_P/-/}.shar.Z"
HOMEPAGE="http://homepages.cwi.nl/~dik/english/ftp.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	unshar ${MY_P/-/}.shar
	cd ${PN}

	sed -i.orig \
		-e "s:CF =\t\(.*\):CF = \1 $CFLAGS:g" \
		-e "s:-DBSD::g" \
		-e "s:-DDEBUG::g" \
		-e "s:/ufs/dik/tmpbin:$D/usr/bin:g" \
		makefile
}

src_compile() {
	emake || die "build failed"
}

src_install() {
	dodir /usr/bin
	einstall || die "install failed"

	doman man/*.1
	dodoc README doc/*
}
