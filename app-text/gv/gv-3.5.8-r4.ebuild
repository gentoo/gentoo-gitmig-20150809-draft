# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.5.8-r4.ebuild,v 1.11 2005/04/03 05:54:30 j4rg0n Exp $

inherit eutils

DESCRIPTION="standard ghostscript frontend used by programs like LyX"
HOMEPAGE="http://wwwthep.physik.uni-mainz.de/~plass/gv/"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gv/unix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc amd64 ~mips ~ppc-macos"
IUSE=""

# There's probably more, but ghostscript also depends on it,
# so I can't identify it
DEPEND="virtual/x11
	x11-libs/Xaw3d
	virtual/ghostscript"
PROVIDE="virtual/pdfviewer
	virtual/psviewer"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-debian.diff.gz
}

src_compile() {

	use ppc-macos && epatch ${FILESDIR}/${P}-setenv.diff

	cp config.Unix 1
	sed -e 's:usr/local:usr:' 1 > config.Unix
	sed -i -e "s:SCRATCH_DIR = ~/:SCRATCH_DIR = /tmp/:g" config.Unix
	rm 1

	xmkmf || die
	make Makefiles || die

	cd source
	sed -i \
		-e 's/install.man:: gv.man/install.man::/' \
		-e 's/all:: gv./\#all:: gv./' \
		-e '/gv.man/ c \#removed by sed for ebuilding' \
		Makefile
	if [ ! "`grep gv.man Makefile`" = "" ] ; then
		ewarn "sed didn't completely remove gv.man references from the Makefile."
		ewarn "We'll just run make and pray."
	fi

	cd ${S}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	make GV_DOCDIR=${D}/usr/share/doc/${PF} install.doc || die
	newman doc/gv.man gv.1
}
