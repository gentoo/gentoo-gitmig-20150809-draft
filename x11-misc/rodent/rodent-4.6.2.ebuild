# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rodent/rodent-4.6.2.ebuild,v 1.4 2011/05/26 16:12:26 angelos Exp $

EAPI=4
inherit autotools eutils fdo-mime gnome2-utils

DESCRIPTION="a fast, small and powerful file manager and graphical shell"
HOMEPAGE="http://rodent.xffm.org"
SRC_URI="mirror://sourceforge/project/xffm/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2:2
	dev-libs/libzip
	sys-apps/file
	x11-libs/gtk+:2
	x11-libs/libSM
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="ChangeLog README TODO"

src_prepare() {
	rm -f Build/bin/*.desktop

	epatch \
		"${FILESDIR}"/${P}-libs.patch \
		"${FILESDIR}"/${P}-validate.patch

	eautoreconf
}

src_install() {
	default

	find "${D}" -name '*.la' -exec rm -f {} +
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
