# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subtitlecomposer/subtitlecomposer-0.4.3.ebuild,v 1.1 2009/02/15 17:39:50 carlo Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="Text-based subtitles editor"
HOMEPAGE="http://www.opendesktop.org/content/show.php/Subtitle+Composer?content=69822"
SRC_URI="mirror://sourceforge/subcomposer/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gstreamer mplayer xine"

DEPEND="|| ( kde-base/kate:3.5 kde-base/kdebase:3.5 )
	gstreamer? ( media-libs/gstreamer )
	mplayer? ( media-video/mplayer )
	xine? ( media-libs/xine-lib )"
RDEPEND="${DEPEND}"

need-kde 3.5

src_compile() {
	local myconf="$(use_with gstreamer) $(use_with xine)"
	kde_src_compile
}
