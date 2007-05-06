# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.8_beta1.ebuild,v 1.1 2007/05/06 21:35:52 genstef Exp $

inherit kde

MY_P="${P/_/-}"
DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://extragear.kde.org/apps/yakuake/"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( kde-base/konsole
	kde-base/kdebase )"

RDEPEND="${DEPEND}"
S=${WORKDIR}/${MY_P}

need-kde 3.3
