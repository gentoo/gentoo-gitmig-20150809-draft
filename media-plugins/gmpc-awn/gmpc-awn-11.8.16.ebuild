# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-awn/gmpc-awn-11.8.16.ebuild,v 1.3 2011/10/09 16:52:05 maekke Exp $

EAPI=4
inherit autotools

DESCRIPTION="This plugin integrates GMPC with the Avant Window Navigator"
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_AWN"
SRC_URI="http://download.sarine.nl/Programs/gmpc/11.8/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND=">=media-sound/gmpc-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.20.0-multilib.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	default
	find "${ED}" -name "*.la" -exec rm {} + || die
}
