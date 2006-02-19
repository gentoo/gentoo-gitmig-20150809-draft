# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-nebulus/xmms-nebulus-0.7.0.ebuild,v 1.1 2006/02/19 17:33:19 metalgod Exp $

IUSE=""

DESCRIPTION="OpenGL/SDL visualization plugin for XMMS"
HOMEPAGE="http://nebulus.tuxfamily.org/"
SRC_URI="http://nebulus.tuxfamily.org/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
#-sparc: 0.6.0: xmms segfaults after SDL thread creation
KEYWORDS="~amd64 ~ppc -sparc ~x86"

DEPEND="media-sound/xmms
	media-libs/libsdl"

src_install () {
	make DESTDIR=${D} install || die
}

