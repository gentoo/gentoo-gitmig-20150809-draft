# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-meanwhile/gaim-meanwhile-1.2.8.ebuild,v 1.5 2007/01/05 04:31:54 flameeyes Exp $


DESCRIPTION="Gaim Meanwhile (Sametime protocol) Plugin"
HOMEPAGE="http://meanwhile.sourceforge.net/"
SRC_URI="mirror://sourceforge/meanwhile/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DEPEND="dev-util/pkgconfig
	>=net-libs/meanwhile-0.5.0
	=net-im/gaim-1.5.0"
IUSE=""

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL README
}

