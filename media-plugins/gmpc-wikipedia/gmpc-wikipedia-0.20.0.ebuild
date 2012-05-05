# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-wikipedia/gmpc-wikipedia-0.20.0.ebuild,v 1.6 2012/05/05 08:27:20 jdhore Exp $

EAPI=3

DESCRIPTION="This plugin shows the Wikipedia article about the currently playing artist"
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_WIKIPEDIA"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2:2
	net-libs/webkit-gtk:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_configure() {
	econf \
		$(use_enable nls) \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	find "${ED}" -name "*.la" -delete || die
}
