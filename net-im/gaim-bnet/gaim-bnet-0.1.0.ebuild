# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-bnet/gaim-bnet-0.1.0.ebuild,v 1.1 2005/02/10 19:20:38 rizzo Exp $

inherit debug

DESCRIPTION="gaim-bnet is an Battle.net chat protocol plug-in for Gaim"
HOMEPAGE="http://gaim-bnet.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-im/gaim-1.0.0"
#RDEPEND=""

src_install() {
	make install DESTDIR=${D} || die "install failure"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README VERSION
}
