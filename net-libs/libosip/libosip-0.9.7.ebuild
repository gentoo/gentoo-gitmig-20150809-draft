# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosip/libosip-0.9.7.ebuild,v 1.6 2004/08/08 15:32:55 stkn Exp $

DESCRIPTION="GNU Open SIP (oSIP) library"
HOMEPAGE="http://www.fsf.org/software/osip/"
SRC_URI="http://osip.atosc.org/download/osip/${P}.tar.gz"

SLOT="1"
LICENSE="LGPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_install () {
	einstall || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
}
