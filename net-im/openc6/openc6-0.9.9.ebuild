# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/openc6/openc6-0.9.9.ebuild,v 1.3 2009/12/29 18:24:57 ssuominen Exp $

EAPI=2
inherit qt3

DESCRIPTION="An open source C6 client"
HOMEPAGE="http://openc6.sourceforge.net/"
SRC_URI="mirror://sourceforge/openc6/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/qt:3
	x11-libs/libX11
	x11-libs/libXScrnSaver"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README* TODO
}
