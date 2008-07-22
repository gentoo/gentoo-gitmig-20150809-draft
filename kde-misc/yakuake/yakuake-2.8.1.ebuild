# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.8.1.ebuild,v 1.3 2008/07/22 18:32:10 jer Exp $

USE_KEG_PACKAGING=1

LANGS="de el es et fr hu it ja nl pl pt_BR pt sv tr"

inherit kde

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://yakuake.kde.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( =kde-base/kdebase-3.5*
	=kde-base/konsole-3.5* )"
RDEPEND="${DEPEND}"

need-kde 3.5
