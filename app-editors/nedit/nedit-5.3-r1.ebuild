# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nedit/nedit-5.3-r1.ebuild,v 1.9 2004/01/11 13:32:04 lanius Exp $

MY_PV=${PV/./_}
DESCRIPTION="multi-purpose Motif-based text editor for the X Window System"
HOMEPAGE="http://nedit.org/"
SRC_URI="mirror://nedit/v${MY_PV}/${P}-source.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

RDEPEND="x11-libs/openmotif"
DEPEND="${RDEPEND}
	dev-util/yacc"

src_unpack() {
	unpack ${A}
	cd ${S}/makefiles
	sed -i -e "s:-O:${CFLAGS}:" -e "s/-lm/-lm -lXmu/" \
	 Makefile.linux || die
}

src_compile() {
	make linux || die
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
