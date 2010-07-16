# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ipmiutil/ipmiutil-2.6.7.ebuild,v 1.1 2010/07/16 11:42:12 ssuominen Exp $

EAPI=2
inherit autotools

DESCRIPTION="IPMI Management Utilities"
HOMEPAGE="http://ipmiutil.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
	virtual/os-headers"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO doc/UserGuide
}
