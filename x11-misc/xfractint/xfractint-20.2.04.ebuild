# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfractint/xfractint-20.2.04.ebuild,v 1.18 2004/07/20 14:46:40 spock Exp $

inherit eutils flag-o-matic

MY_P=xfract${PV}

S=${WORKDIR}
DESCRIPTION="The best fractal generator for X."
HOMEPAGE="http://www.fractint.org"
SRC_URI="http://www.fractint.org/ftp/old/linux/${MY_P}.zip"

KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="freedist"
IUSE=""

DEPEND="app-arch/unzip
	virtual/libc
	>=sys-libs/ncurses-5.1
	virtual/x11"

src_unpack() {
	unpack ${MY_P}.zip
}

src_compile() {
	cd ${S}
	cp Makefile Makefile.orig
	replace-flags "-funroll-all-loops" "-funroll-loops"
	sed -e "s:CFLAGS = :CFLAGS = $CFLAGS :" Makefile.orig >Makefile

	emake
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/xfractint
	   	dodir /usr/man/man1

	make \
		BINDIR=${D}usr/bin \
		MANDIR=${D}usr/man/man1 \
		SRCDIR=${D}usr/share/xfractint \
		MAPFILES="" \
		install || die

	insinto /etc/env.d
	newins ${FILESDIR}/xfractint.envd 60xfractint
}
