# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libuta/libuta-0.4.3.ebuild,v 1.4 2004/03/19 07:56:04 mr_bones_ Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a GUI library for C++ that uses SDL as its output layer"
SRC_URI="mirror://sourceforge/libuta/${P}.tar.gz"
HOMEPAGE="http://libuta.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2 GPL-2"
KEYWORDS="x86"

DEPEND="media-libs/libsdl
	media-libs/libpng
	sys-libs/zlib
	=media-libs/freetype-1.3*
	=dev-libs/libsigc++-1.0*"

src_install() {
	make DESTDIR=${D} install || die
}
