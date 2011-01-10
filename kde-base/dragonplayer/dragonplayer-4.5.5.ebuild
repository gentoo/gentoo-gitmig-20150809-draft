# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dragonplayer/dragonplayer-4.5.5.ebuild,v 1.1 2011/01/10 11:53:20 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
HOMEPAGE="http://www.dragonplayer.net/"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE="debug"

RDEPEND="
	aqua? ( >=media-libs/xine-lib-1.1.9 )
	!aqua? ( >=media-libs/xine-lib-1.1.9[xcb] )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
