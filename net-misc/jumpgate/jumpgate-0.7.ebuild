# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jumpgate/jumpgate-0.7.ebuild,v 1.4 2003/12/10 22:37:25 avenj Exp $

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

