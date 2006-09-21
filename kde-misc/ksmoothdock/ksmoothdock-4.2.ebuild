# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksmoothdock/ksmoothdock-4.2.ebuild,v 1.1 2006/09/21 23:33:22 troll Exp $

inherit kde

MY_P="${P}_automake1.9"
S="${WORKDIR}/${PN}"

DESCRIPTION="KSmoothDock is a dock program for KDE with smooth parabolic zooming."
HOMEPAGE="http://ksmoothdock.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

need-kde 3.4
