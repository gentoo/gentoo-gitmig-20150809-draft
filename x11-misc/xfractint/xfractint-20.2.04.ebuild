# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfractint/xfractint-20.2.04.ebuild,v 1.3 2002/08/14 23:44:15 murphy Exp $

MY_P=xfract${PV}

S=${WORKDIR}
DESCRIPTION="The best fractal generator for X."
HOMEPAGE="http://www.fractint.org"
SRC_URI="http://www.fractint.org/ftp/current/linux/${MY_P}.zip"

KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="freeware"

DEPEND="app-arch/unzip
	virtual/glibc
	>=sys-libs/ncurses-5.1
	x11-base/xfree"

RDEPEND=$DEPEND

src_unpack() {
	unpack ${MY_P}.zip
}


src_compile() {
	cd ${S}
	cp Makefile Makefile.orig
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




