# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/savirc/savirc-1.99.ebuild,v 1.2 2004/10/17 10:04:27 dholm Exp $

DESCRIPTION="User friendly IRC client with unicode support and tcl/tk scripting"
SRC_URI="http://www.savirc.com/Downloads/savirc-Lin/${P}.tar.gz"
HOMEPAGE="http://www.savirc.com/"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=dev-lang/tcl-8.3.0
	>=dev-lang/tk-8.3.0"
DEPEND=""

src_install() {
	make PREFIX=/usr DESTDIR=${D}/usr install || die "make install failed"
}
