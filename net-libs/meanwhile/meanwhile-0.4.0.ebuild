# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/meanwhile/meanwhile-0.4.0.ebuild,v 1.2 2005/03/18 22:04:02 rizzo Exp $

DESCRIPTION="Meanwhile (Sametime protocol) library"
HOMEPAGE="http://meanwhile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
}
