# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-bnet/gaim-bnet-0.1.1.ebuild,v 1.3 2007/07/12 05:34:48 mr_bones_ Exp $

DESCRIPTION="gaim-bnet is an Battle.net chat protocol plug-in for Gaim"
HOMEPAGE="http://gaim-bnet.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-im/gaim-1.0.0"
#RDEPEND=""

src_install() {
	make install DESTDIR=${D} || die "install failure"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README VERSION
}
