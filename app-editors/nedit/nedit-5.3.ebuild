# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/nedit/nedit-5.3.ebuild,v 1.3 2002/08/06 16:32:08 gerk Exp $

S=${WORKDIR}/${P}
MY_PV=${PV/./_}
DESCRIPTION="NEdit is a multi-purpose text editor for the X Window System"
SRC_URI="http://www.nedit.org/ftp/v${MY_PV}/${P}-source.tar.gz"
HOMEPAGE="http://nedit.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND=">=x11-libs/openmotif-2.1.30"

DEPEND="${RDEPEND}
	dev-util/yacc"

src_unpack() {

	unpack ${A}
	cd ${S}/makefiles
	cp Makefile.linux Makefile.orig
	sed -e "s:-O:${CFLAGS}:" Makefile.orig > Makefile.linux

}

src_compile() {

	make linux || die

}

src_install () {

	into /usr
	dobin source/nc source/nedit
	newman doc/nedit.man nedit.1
	newman doc/nc.man nc.1

	dodoc README ReleaseNotes ChangeLog COPYRIGHT
	cd doc
	dodoc *.txt nedit.doc README.FAQ NEdit.ad
	dohtml *.{dtd,xsl,xml,html,awk}

}
