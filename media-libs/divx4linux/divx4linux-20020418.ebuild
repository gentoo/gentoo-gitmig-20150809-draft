# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/divx4linux/divx4linux-20020418.ebuild,v 1.8 2002/09/11 20:09:46 gerk Exp $

DXVER=501
S="${WORKDIR}/${PN}-${PV}"
DESCRIPTION="Binary release of DivX Codec 5.0.1"
SRC_URI="http://download.divx.com/divx/${PN}${DXVER}-${PV}.tgz"
HOMEPAGE="http://www.divx.com/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="DIVX"
KEYWORDS="x86 -ppc -sparc -sparc64"


# Make sure Portage does _NOT_ strip symbols.  Need both lines for
# Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"

src_install() {
	
	dodir /usr/{lib,include}

	# Do the divx50 decoder stuff
	dolib.so *.so
	insinto /usr/include
	doins *.h
	dodoc README.linux license.txt
	mkdir ${D}/usr/share/doc/${P}/html
	cp -a 'DivX MPEG-4 Codec and Its Interface.htm' ${D}/usr/share/doc/${P}/html
}
