# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.9.0.ebuild,v 1.1 2005/07/31 23:13:59 carlo Exp $

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}a"

DESCRIPTION="MPlayer frontend for KDE"
HOMEPAGE="http://www.xs4all.nl/~jjvrieze/kmplayer.html"
SRC_URI="http://www.xs4all.nl/~jjvrieze/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gstreamer xine"

# Removed koffice plugin, since the compilation fails and it's not supported upstream.
DEPEND=">=media-video/mplayer-0.90
	xine? ( >=media-libs/xine-lib-1_beta12 )
	gstreamer? ( >=media-libs/gst-plugins-0.8.7 )"
need-kde 3.1

src_compile(){
	local myconf="$(use_with gstreamer) $(use_with xine)"
	kde_src_compile
}
