# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/roadnav/roadnav-0.16.ebuild,v 1.2 2007/06/16 00:57:46 dirtyepic Exp $

inherit wxwidgets

DESCRIPTION="Roadnav is a street map application with routing and GPS support"
HOMEPAGE="http://roadnav.sourceforge.net"
SRC_URI="mirror://sourceforge/roadnav/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gps festival openstreetmap scripting"

DEPEND="=x11-libs/wxGTK-2.6*
	=dev-libs/libroadnav-${PV}
	gps? ( sci-geosciences/gpsd )
	festival? ( app-accessibility/festival )"
RDEPEND="=x11-libs/wxGTK-2.6*
	gps? ( sci-geosciences/gpsd )
	festival? ( app-accessibility/festival )"

src_compile() {
	WX_GTK_VER=2.6
	need-wxwidgets gtk2

	econf \
	--with-wx-config=${WX_CONFIG} \
	$(use_enable gps gpsd) \
	$(use_enable openstreetmap) \
	$(use_enable scripting) \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
