# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
HOMEPAGE="http://wmpager.sourceforge.net/"
DESCRIPTION="wmpager is a simple pager docklet for the Window Maker."
SRC_URI="mirror://sourceforge/wmpager/wmpager-${PV}.tar.gz"
SLOT="0"
LICENSE=""
KEYWORDS="~x86"
DEPEND=""
RDEPEND=""

src_compile() {
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s:INSTALLDIR = .*:INSTALLDIR=${D}/usr:" Makefile.orig > Makefile
	cd src
	mv wmpager.c wmpager.c.orig
	sed -e "s:WMPAGER_DEFAULT_INSTALL_DIR .*:WMPAGER_DEFAULT_INSTALL_DIR \"/usr/share/wmpager\":" wmpager.c.orig > wmpager.c
	cd ..
	emake || die
}

src_install() {
	cd ${S}
	emake install || die
	dodoc README
}
