# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/ksmoothdock/ksmoothdock-3.2.ebuild,v 1.1 2004/05/01 11:17:58 centic Exp $

inherit kde-base || die
need-kde 3.2

DESCRIPTION="KSmoothDock is a dock program for KDE with smooth parabolic zooming."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://ksmoothdock.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""
SLOT="0"

