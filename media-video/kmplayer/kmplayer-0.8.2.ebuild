# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.8.2.ebuild,v 1.3 2004/02/09 16:16:53 caleb Exp $

inherit kde
need-kde 3.1

DESCRIPTION="MPlayer frontend for KDE"
HOMEPAGE="http://www.xs4all.nl/~jjvrieze/kmplayer.html"
SRC_URI="http://www.xs4all.nl/~jjvrieze/${P}.tar.bz2"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86 ~ppc amd64"
S=${WORKDIR}/${PN}

DEPEND=">=kde-base/kdelibs-3.1
	>=media-video/mplayer-0.90
	>=media-libs/xine-lib-1_beta12"

src_compile()
{
	# This support only get compiled in if you already have koffice emerged, so
	# there's no need for any use flags or dep checking.
	myconf="$myconf --enable-koffice-plugin"
	kde_src_compile
}
