# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nedit/nedit-5.3-r2.ebuild,v 1.14 2004/04/19 07:59:07 vapier Exp $

inherit eutils gcc

MY_PV=${PV/./_}
DESCRIPTION="multi-purpose text editor for the X Window System"
HOMEPAGE="http://nedit.org/"
SRC_URI="mirror://nedit/v${MY_PV}/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE="spell"

RDEPEND="spell? ( virtual/aspell-dict )
	virtual/x11"
DEPEND="${RDEPEND}
	dev-util/yacc
	x11-libs/openmotif"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gentoo.diff

	sed -i "s:-O:${CFLAGS} -D__LINUX__:" \
	 ${S}/makefiles/Makefile.linux
}

src_compile() {
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
