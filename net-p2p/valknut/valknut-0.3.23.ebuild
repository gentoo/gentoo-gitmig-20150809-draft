# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/valknut/valknut-0.3.23.ebuild,v 1.2 2009/12/22 16:18:26 jer Exp $

EAPI=1

inherit qt3

DESCRIPTION="Qt based client for DirectConnect"
HOMEPAGE="http://sourceforge.net/projects/wxdcgui/"
SRC_URI="mirror://sourceforge/wxdcgui/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt:3
	>=dev-libs/libxml2-2.4.22
	~net-p2p/dclib-${PV}
	dev-libs/openssl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		--with-qt-dir=${QTDIR} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
