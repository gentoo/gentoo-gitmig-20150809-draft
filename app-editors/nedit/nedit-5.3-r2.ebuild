# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nedit/nedit-5.3-r2.ebuild,v 1.3 2003/02/13 06:58:01 vapier Exp $

inherit eutils

S=${WORKDIR}/${P}
MY_PV=${PV/./_}
DESCRIPTION="NEdit is a multi-purpose text editor for the X Window System"
SRC_URI="http://www.nedit.org/ftp/v${MY_PV}/${P}-source.tar.gz"
HOMEPAGE="http://nedit.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

RDEPEND="spell? ( app-text/aspell )"

DEPEND="${RDEPEND}
	dev-util/yacc
	virtual/motif"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gentoo.diff

	cp ${S}/makefiles/Makefile.linux ${T}
	sed "s:-O:${CFLAGS} -D__LINUX__:" \
		${T}/Makefile.linux > ${S}/makefiles/Makefile.linux
}

src_compile() {
	make linux || die
}

src_install () {
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
