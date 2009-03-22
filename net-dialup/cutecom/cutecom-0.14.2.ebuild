# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/cutecom/cutecom-0.14.2.ebuild,v 1.1 2009/03/22 11:19:30 mrness Exp $

EAPI=1

inherit eutils cmake-utils qt3

DESCRIPTION="CuteCom is a serial terminal, like minicom, written in qt"
HOMEPAGE="http://cutecom.sourceforge.net"
SRC_URI="http://cutecom.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="x11-libs/qt:3"
RDEPEND="${DEPEND}
	net-dialup/lrzsz"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-manpath.patch
}
