# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.5.8-r1.ebuild,v 1.13 2003/09/05 22:37:21 msterret Exp $

# this r1 is a major change. it uses sed instead of patches.
# hopefully this will enable everyone to compile gv on widely
# different configurations, eliminating the gv.man/gv._man problem

DESCRIPTION="standard ghostscript frontend used by programs like LyX"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gv/unix/${P}.tar.gz"
HOMEPAGE="http://wwwthep.physik.uni-mainz.de/~plass/gv/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"

# There's probably more, but ghostscript also depends on it,
# so I can't identify it
DEPEND="virtual/x11
	x11-libs/Xaw3d
	app-text/ghostscript"

src_compile() {
	cp config.Unix 1
	sed -e 's:usr/local:usr:' 1 > config.Unix
	rm 1

	xmkmf || die
	make Makefiles || die

	cd source

	cp Makefile 1
	cat 1 | sed -e 's/install.man:: gv.man/install.man::/' \
		-e 's/all:: gv./\#all:: gv./' \
		-e '/gv.man/ c \#removed by sed for ebuilding' > Makefile
	rm 1
	if [ ! "`grep gv.man Makefile`" = "" ];
	then
		echo "sed didn't completely remove gv.man references from the Makefile."
		echo "We'll just run make and pray."
		sleep 2s
	fi


	cd ${S}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	make GV_DOCDIR=${D}/usr/share/doc/${PF} install.doc || die
	newman doc/gv.man gv.1
}
