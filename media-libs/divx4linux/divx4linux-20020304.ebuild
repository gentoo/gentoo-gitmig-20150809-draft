# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/divx4linux/divx4linux-20020304.ebuild,v 1.1 2002/04/23 22:36:07 azarah Exp $

OLD_VER=20011025
S="${WORKDIR}/${PN}-${PV}"
DESCRIPTION="Binary release of DivX Codec 5.0"
SRC_URI="http://download.divx.com/divx/${PN}50-${PV}.tgz
	http://avifile.sourceforge.net/${PN}-${OLD_VER}.tgz
	ftp://ftp.ibiblio.org/pub/linux/distributions/gentoo/distfiles/${PN}-${OLD_VER}.tgz"
HOMEPAGE="http://www.divx.com/"

DEPEND="virtual/glibc"

SLOT="0"

src_install() {
	
	dodir /usr/{lib,include}

	# Do the divx50 decoder stuff
	dolib.so *.so
	insinto /usr/include
	doins *.h
	dodoc RELNOTES.linux license.txt

	# Do the divx40 encoder stuff
	cd ${WORKDIR}/${PN}-${OLD_VER}
	dolib.so libdivxencore.so
	doins encore2.h mv_hint.h
	docinto DX40
	dodoc RELNOTES.linux license.txt
	cp -a 'Codec Core Interface.txt' ${D}/usr/share/doc/${P}/DX40/
}

