# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-nebulus/xmms-nebulus-0.2.0.ebuild,v 1.2 2002/07/22 00:48:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="OpenGL/SDL visualization plugin for XMMS"
HOMEPAGE="http://nebulus.tuxfamily.org/"
SRC_URI="http://nebulus.tuxfamily.org/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms
	media-libs/libsdl"

src_compile() {
	econf || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	
}
