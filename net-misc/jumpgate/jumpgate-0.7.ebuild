# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jumpgate/jumpgate-0.7.ebuild,v 1.5 2004/06/24 23:51:05 agriffis Exp $

DESCRIPTION="An advanced TCP connection forwarder."
HOMEPAGE="http://jumpgate.sourceforge.net"
SRC_URI="http://jumpgate.sourceforge.net/${P}.tar.gz"
LICENSE="as-is"
S=${WORKDIR}/${P}

SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
DEPEND=""
RDEPEND=""

src_install() {
	make install install_prefix=${D} || die
	dodoc README ChangeLog
}

