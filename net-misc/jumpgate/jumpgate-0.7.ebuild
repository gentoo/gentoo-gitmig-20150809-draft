# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jumpgate/jumpgate-0.7.ebuild,v 1.1 2002/12/17 20:00:22 aliz Exp $

DESCRIPTION="An advanced TCP connection forwarder."
HOMEPAGE="http://jumpgate.sourceforge.net"
SRC_URI="http://jumpgate.sourceforge.net/${P}.tar.gz"
LICENSE="as-is"
S=${WORKDIR}/${P}

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_install() {
	make install install_prefix=${D} || die
	dodoc README ChangeLog
}

