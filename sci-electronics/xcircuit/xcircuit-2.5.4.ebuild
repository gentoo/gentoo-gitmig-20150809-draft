# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/xcircuit/xcircuit-2.5.4.ebuild,v 1.2 2005/02/05 11:15:08 hansmi Exp $

inherit flag-o-matic eutils

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://xcircuit.ece.jhu.edu/archive/${P}.tar.bz2"
HOMEPAGE="http://xcircuit.ece.jhu.edu"

KEYWORDS="x86 ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/x11
		dev-lang/python
		virtual/ghostscript"

#looks like -O3 causes problems at times
replace-flags -O3 -O2

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-${PV}-XQueryColor.patch

	#only apply this patch if under gcc-3.2
	if [ "`gcc -dumpversion | cut -d. -f1,2`" == "3.2" ]; then
		epatch ${FILESDIR}/${PN}-${PV}-sigsegv.patch
	fi

}


src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"

	#Parallel make bombs on parameter.c looking for menudep.h
	make || die

}

src_install () {

	make DESTDIR=${D} install || die "Installation failed"

	dodoc COPYRIGHT README*

}
