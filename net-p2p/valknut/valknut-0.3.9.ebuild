# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/valknut/valknut-0.3.9.ebuild,v 1.6 2007/08/27 15:01:24 angelos Exp $

inherit qt3 eutils

DESCRIPTION="Qt based client for DirectConnect"
HOMEPAGE="http://sourceforge.net/projects/wxdcgui/"
SRC_URI="mirror://sourceforge/wxdcgui/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 x86"
IUSE="ssl"

DEPEND="$(qt_min_version 3)
	>=dev-libs/libxml2-2.4.22
	~net-p2p/dclib-${PV}
	ssl? ( dev-libs/openssl )"

src_compile() {
	econf \
		$(use_with ssl) \
		--with-libdc=/usr \
		--with-qt-dir=${QTDIR} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
