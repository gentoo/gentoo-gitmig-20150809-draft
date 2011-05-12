# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/plasma-mpd-nowplaying/plasma-mpd-nowplaying-0.2.ebuild,v 1.2 2011/05/12 14:11:19 scarabeus Exp $

EAPI=4

MY_PN="mpdnowplaying"
MY_P=${MY_PN}-${PV}
KDE_LINGUAS="de pt_BR"
inherit kde4-base

DESCRIPTION="Plasmoid attached to MPD displaying currently played item"
HOMEPAGE="http://kde-look.org/content/show.php/MPD+Now+Playing?content=132350"
SRC_URI="http://kde-look.org/CONTENT/content-files/132350-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${MY_PN}
