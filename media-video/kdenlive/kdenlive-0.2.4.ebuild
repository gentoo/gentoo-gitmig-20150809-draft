# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kdenlive/kdenlive-0.2.4.ebuild,v 1.11 2005/01/23 21:27:09 centic Exp $

inherit eutils gcc kde

DESCRIPTION="Kdenlive! (pronounced Kay-den-live) is a Non Linear Video Editing Suite for KDE."
HOMEPAGE="http://kdenlive.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdenlive/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=media-video/piave-0.2.4
	|| ( kde-base/kdesdk-meta >=kde-base/kdesdk-3.2 )"
need-kde 3

src_unpack() {
	unpack ${A}
	if [ "`gcc-minor-version`" -eq "4" ]
	then
	epatch ${FILESDIR}/kdenlive-0.2.4-gcc34.patch
	fi
}
