# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/modplugbmp/modplugbmp-2.05.ebuild,v 1.1 2004/12/16 16:11:56 chainsaw Exp $

IUSE=""

DESCRIPTION="BMP plugin for MOD-like music files"
SRC_URI="http://thefun.trucs.org/${P}.tar.bz2"
HOMEPAGE="http://thefun.trucs.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=media-sound/beep-media-player-0.9.7
	>=media-libs/libmodplug-0.7"

src_install () {
	make DESTDIR=${D} install || die
}

