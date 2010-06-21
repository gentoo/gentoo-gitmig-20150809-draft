# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.9.6.ebuild,v 1.8 2010/06/21 17:08:20 ssuominen Exp $

EAPI="2"

KDE_LINGUAS="ca cs da de el en_GB es et fr ga gl hne it ja ko nds nl nn pl pt
pt_BR ro ru sv th tr uk wa zh_CN"
inherit kde4-base

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
SLOT="4"
IUSE=""

DEPEND=">=kde-base/konsole-${KDE_MINIMAL}
	sys-devel/gettext"
RDEPEND="${DEPEND}"
