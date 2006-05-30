# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/mtaskbar/mtaskbar-0.7.ebuild,v 1.1 2006/05/30 21:35:30 jokey Exp $

inherit kde eutils

DESCRIPTION="A beautiful taskbar for KDE's kicker"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=16261"
SRC_URI="http://www.uni-weimar.de/~wolff3/kdelook/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/${P}/${PN}

need-kde 3.3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gcc4.patch
	epatch ${FILESDIR}/${PN}-desktop.patch
}
