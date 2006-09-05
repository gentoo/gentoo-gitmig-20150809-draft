# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/roadnav/roadnav-0.15.ebuild,v 1.1 2006/09/05 18:54:15 kloeri Exp $

DESCRIPTION="Roadnav is a street map application with routing and GPS support"
HOMEPAGE="http://roadnav.sourceforge.net"
SRC_URI="mirror://sourceforge/roadnav/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gps festival"

DEPEND=">=x11-libs/wxGTK-2.6.2-r1
	=dev-libs/libroadnav-${PV}
	gps? ( sci-geosciences/gpsd )
	festival? ( app-accessibility/festival )"
RDEPEND=">=x11-libs/wxGTK-2.6.2-r1
	gps? ( sci-geosciences/gpsd )
	festival? ( app-accessibility/festival )"

src_compile() {
	econf \
	--with-wx-config=wx-config-2.6 \
	--with-wx-config-path=/usr/bin \
	$(use_enable gps gpsd) \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
