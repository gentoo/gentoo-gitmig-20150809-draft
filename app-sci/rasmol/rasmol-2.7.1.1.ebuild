# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/rasmol/rasmol-2.7.1.1.ebuild,v 1.4 2004/04/27 08:23:44 vapier Exp $

inherit gcc

MY_P="RasMol_${PV}"

DESCRIPTION="Free program that displays molecular structure."
HOMEPAGE="http://www.openrasmol.org/"
SRC_URI="http://www.bernstein-plus-sons.com/software/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Hack required for build
	cd src
	ln -s ../doc
	gunzip doc/rasmol.1.gz
}

src_compile() {
	cd src
	xmkmf || die "xmkmf failed"
	make DEPTHDEF=-DEIGHTBIT CC=${CC} \
		CDEBUGFLAGS="${CFLAGS}" \
		|| die "8-bit make failed"
	mv rasmol rasmol.8
	make clean
	make DEPTHDEF=-DSIXTEENBIT CC="$(gcc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" \
		|| die "16-bit make failed"
	mv rasmol rasmol.16
	make clean
	make DEPTHDEF=-DTHIRTYTWOBIT CC="$(gcc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" \
		|| die "32-bit make failed"
	mv rasmol rasmol.32
	make clean
}

src_install () {
	newbin ${FILESDIR}/rasmol.sh.debian rasmol
	insinto /usr/lib/${PN}
	doins doc/rasmol.hlp
	exeinto /usr/lib/${PN}
	doexe src/rasmol.{8,16,32}
	dodoc INSTALL PROJECTS README TODO doc/*.{ps,pdf}.gz doc/rasmol.txt.gz
	doman doc/rasmol.1
	insinto /usr/lib/${PN}/databases
	doins data/*
}
