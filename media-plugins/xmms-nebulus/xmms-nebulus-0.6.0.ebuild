# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-nebulus/xmms-nebulus-0.6.0.ebuild,v 1.2 2004/03/05 21:37:59 jhuebel Exp $

S=${WORKDIR}/${P}
DESCRIPTION="OpenGL/SDL visualization plugin for XMMS"
HOMEPAGE="http://nebulus.tuxfamily.org/"
SRC_URI="http://nebulus.tuxfamily.org/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="media-sound/xmms
	media-libs/libsdl"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die
}

