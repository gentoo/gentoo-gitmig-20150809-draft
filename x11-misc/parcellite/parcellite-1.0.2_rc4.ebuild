# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/parcellite/parcellite-1.0.2_rc4.ebuild,v 1.1 2011/09/06 08:14:31 hwoarang Exp $

EAPI=4
inherit fdo-mime autotools

MY_PV="${PV/_/}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A lightweight GTK+ based clipboard manager."
HOMEPAGE="http://parcellite.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=dev-libs/glib-2.14:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext
		dev-util/intltool )"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls)
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
