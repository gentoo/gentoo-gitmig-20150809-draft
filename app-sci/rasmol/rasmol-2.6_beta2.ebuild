# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/rasmol/rasmol-2.6_beta2.ebuild,v 1.2 2002/07/25 16:18:19 aliz Exp $

DESCRIPTION="Free program which displays molecular structure."
HOMEPAGE="http://www.umass.edu/microbio/rasmol/index2.htm"
KEYWORDS="x86"
SLOT="0"
LICENSE="Public"
LICENSE="Domain"


DEPEND="virtual/x11"

RDEPEND="${DEPEND}"

P0=rasmol_2.6b2
SRC_URI="ftp://ftp.debian.org/debian/pool/main/r/${PN}/${P0}.orig.tar.gz
		ftp://ftp.debian.org/debian/pool/main/r/${PN}/${P0}-6.diff.gz"

S="${WORKDIR}/RasMol2"

src_unpack() {
	unpack ${P0}.orig.tar.gz
	zcat ${DISTDIR}/${P0}-6.diff.gz | patch -d ${S} -p1 || die "debian patch failed"
}

src_compile() {
	xmkmf || die "xmkmf failed"
	make DEPTHDEF=-DEIGHTBIT=1 CC=gcc \
		CDEBUGFLAGS="${CFLAGS} -DLINUX" \
		|| die "8-bit make failed"
	mv rasmol rasmol.8
	make clean
	make DEPTHDEF=-DSIXTEENBIT=1 CC=gcc \
		CDEBUGFLAGS="${CFLAGS} -DLINUX" \
		|| die "16-bit make failed"
	mv rasmol rasmol.16
	make clean
	make DEPTHDEF=-DTHIRTYTWOBIT=1 CC=gcc \
		CDEBUGFLAGS="${CFLAGS} -DLINUX" \
		|| die "32-bit make failed"
	mv rasmol rasmol.32
	make clean
}

src_install () {
	newbin debian/rasmol.sh.debian rasmol
	insinto /usr/lib/${PN}
	doins rasmol.{8,16,32} rasmol.hlp
	chmod a+x ${D}/usr/lib/${PN}/rasmol.{8,16,32}
	dodoc INSTALL Announce PROJECTS README TODO doc/manual.ps doc/rasmol.txt
	dodoc doc/refcard.doc doc/refcard.ps 
	doman debian/rasmol.1
	insinto /usr/lib/${PN}/databases
	doins data/*
}
