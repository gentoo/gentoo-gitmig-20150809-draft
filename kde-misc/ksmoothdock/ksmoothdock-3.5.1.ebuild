# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksmoothdock/ksmoothdock-3.5.1.ebuild,v 1.3 2004/11/25 22:26:31 motaboy Exp $

inherit kde eutils

DESCRIPTION="KSmoothDock is a dock program for KDE with smooth parabolic zooming."
HOMEPAGE="http://ksmoothdock.sourceforge.net"
SRC_URI="mirror://sourceforge/ksmoothdock/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

need-kde 3.2

src_unpack() {
	kde_src_unpack

	use arts || epatch ${FILESDIR}/${P}-configure-arts.patch
}

