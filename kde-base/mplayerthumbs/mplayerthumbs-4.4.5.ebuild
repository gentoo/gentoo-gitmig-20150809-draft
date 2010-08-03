# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mplayerthumbs/mplayerthumbs-4.4.5.ebuild,v 1.2 2010/08/03 07:42:17 hwoarang Exp $

EAPI="3"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="A Thumbnail Generator for Video Files on KDE filemanagers."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=41180"
LICENSE="GPL-2"

KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug mplayer"

RDEPEND="
	!media-video/mplayerthumbs
	|| (
		$(add_kdebase_dep dolphin)
		$(add_kdebase_dep konqueror)
	)
	mplayer? ( media-video/mplayer )
"

src_configure() {
	mycmakeargs=(
		-DENABLE_PHONON_SUPPORT=ON
	)

	kde4-meta_src_configure
}
