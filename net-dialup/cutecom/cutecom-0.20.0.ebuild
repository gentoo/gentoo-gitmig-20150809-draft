# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/cutecom/cutecom-0.20.0.ebuild,v 1.2 2008/07/27 21:58:55 carlo Exp $

EAPI=1

inherit eutils cmake-utils qt4

DESCRIPTION="CuteCom is a serial terminal, like minicom, written in qt"
HOMEPAGE="http://cutecom.sourceforge.net"
SRC_URI="http://cutecom.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="x11-libs/qt:4"
RDEPEND="${DEPEND}
		 net-dialup/lrzsz"
