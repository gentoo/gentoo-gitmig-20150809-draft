# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.8.1-r1.ebuild,v 1.1 2009/10/13 03:00:46 abcd Exp $

EAPI="1"

USE_KEG_PACKAGING=1

LANGS="de el es et fr hu it ja nl pl pt_BR pt sv tr"

inherit kde

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="3.5"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="
	|| (
		kde-base/konsole:3.5
		kde-base/kdebase:3.5
	)
"
RDEPEND="${DEPEND}
	!kde-misc/yakuake:0
"

need-kde 3.5
