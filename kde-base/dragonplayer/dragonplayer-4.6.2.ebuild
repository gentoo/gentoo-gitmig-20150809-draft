# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dragonplayer/dragonplayer-4.6.2.ebuild,v 1.1 2011/04/06 14:19:19 scarabeus Exp $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
HOMEPAGE="http://www.dragonplayer.net/"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE="debug xine"

RDEPEND="
	>=media-libs/phonon-4.4.3
	xine? ( media-libs/xine-lib[xcb] )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with xine)
	)

	kde4-meta_src_configure
}
