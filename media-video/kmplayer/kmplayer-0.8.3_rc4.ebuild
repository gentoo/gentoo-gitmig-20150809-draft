# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.8.3_rc4.ebuild,v 1.1 2004/07/16 16:30:36 carlo Exp $

inherit kde

MY_P="${P/_rc/rc}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="MPlayer frontend for KDE"
HOMEPAGE="http://www.xs4all.nl/~jjvrieze/kmplayer.html"
SRC_URI="http://www.xs4all.nl/~jjvrieze/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=kde-base/kdelibs-3.1
	>=media-video/mplayer-0.90
	>=media-libs/xine-lib-1_beta12"
need-kde 3.1

src_compile()
{
	# This support only get compiled in if you already have koffice emerged, so
	# there's no need for any use flags or dep checking.
	myconf="$myconf --enable-koffice-plugin"
	kde_src_compile
}
