# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kooldock/kooldock-0.3.ebuild,v 1.4 2004/12/05 17:10:10 motaboy Exp $

inherit kde eutils

DESCRIPTION=" KoolDock is a dock for KDE with cool visual enhancements and effects"
HOMEPAGE="http://ktown.kde.cl/kooldock/index.php"
SRC_URI="http://ktown.kde.cl/kooldock/dist/${P}.tar.gz"

S=${WORKDIR}/${PN}

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

SLOT="0"
IUSE=""

need-kde 3.2

src_unpack() {
	kde_src_unpack

	useq arts || epatch ${FILESDIR}/${P}-configure.patch
}