# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kooldock/kooldock-0.3-r1.ebuild,v 1.1 2005/03/31 22:54:36 cryos Exp $

inherit kde eutils

DESCRIPTION=" KoolDock is a dock for KDE with cool visual enhancements and effects"
HOMEPAGE="http://ktown.kde.cl/kooldock/index.php"
SRC_URI="http://ktown.kde.cl/kooldock/dist/${P}.tar.gz"

S=${WORKDIR}/${PN}

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

SLOT="0"
IUSE=""

need-kde 3.2

src_unpack() {
	kde_src_unpack
	# Patch to stop it segfaulting when the mouse exits to the left, bug 85071.
	epatch ${FILESDIR}/${P}-fix-left-segfault.patch
	useq arts || epatch ${FILESDIR}/${P}-configure.patch
}
