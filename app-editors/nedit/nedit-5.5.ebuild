# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nedit/nedit-5.5.ebuild,v 1.5 2005/03/26 22:24:42 kloeri Exp $

inherit gcc

DESCRIPTION="multi-purpose text editor for the X Window System"
HOMEPAGE="http://nedit.org/"
SRC_URI="mirror://sourceforge/nedit/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips amd64 alpha"
IUSE="spell"

RDEPEND="spell? ( virtual/aspell-dict )
	x11-libs/openmotif"
DEPEND="${RDEPEND}
	dev-util/yacc
	x11-libs/openmotif"

src_compile() {
	sed -i -e "s:-Wl,-Bstatic::" makefiles/Makefile.linux
	sed -i -e "s:0.93.0:0.94.0:" util/check_lin_tif.c
	sed -i -e "s:CFLAGS=-O:CFLAGS=${CFLAGS}:" makefiles/Makefile.linux
	sed -i -e 's:"/bin/csh":"/bin/sh":' source/preferences.c
	make CC=$(gcc-getCC) linux || die
}

src_install() {
	into /usr
	dobin source/nedit
	exeinto /usr/bin
	newexe source/nc neditc
	newman doc/nedit.man nedit.1
	newman doc/nc.man neditc.1

	dodoc README ReleaseNotes ChangeLog COPYRIGHT
	cd doc
	dodoc *.txt nedit.doc README.FAQ NEdit.ad
	dohtml *.{dtd,xsl,xml,html,awk}
}
