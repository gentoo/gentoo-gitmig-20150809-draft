# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xcircuit/xcircuit-2.5.4.ebuild,v 1.6 2002/10/15 03:45:07 george Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://bach.ece.jhu.edu/~tim/programs/xcircuit/archive/${P}.tar.bz2"
HOMEPAGE="http://bach.ece.jhu.edu/~tim/programs/xcircuit/xcircuit.html"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/x11
		dev-lang/python
		app-text/ghostscript"
RDEPEND="${DEPEND}"

#looks like -O3 causes problems at times
replace-flags -O3 -O2

src_unpack() {

	unpack ${A}
	cd ${S}
	patch xcircuit.c < ${FILESDIR}/${PN}-${PV}-XQueryColor.patch || die "patch failed"

	#only apply this patch if under gcc-3.2
	if [ "`gcc -dumpversion | cut -d. -f1,2`" == "3.2" ]; then 
		patch files.c <${FILESDIR}/${PN}-${PV}-sigsegv.patch || die "patch failed"
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
