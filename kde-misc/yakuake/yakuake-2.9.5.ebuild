# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.9.5.ebuild,v 1.1 2009/05/13 08:17:46 scarabeus Exp $

EAPI="2"

KDE_LINGUAS="ca cs da de el en_GB fr ga gl ja ko nds nl pt pt_BR ro ru sv tr uk"
inherit kde4-base

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="4"
IUSE=""

DEPEND=">=kde-base/konsole-${KDE_MINIMAL}
	sys-devel/gettext"
RDEPEND="${DEPEND}
	!kde-misc/yakuake:4.1
"
