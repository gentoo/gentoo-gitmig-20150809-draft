# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/viewnior/viewnior-1.0.ebuild,v 1.3 2010/06/29 08:30:53 fauli Exp $

EAPI="2"
inherit fdo-mime gnome2-utils

DESCRIPTION="Fast and simple image viewer"
HOMEPAGE="http://xsisqox.github.com/Viewnior/index.html"
SRC_URI="http://cloud.github.com/downloads/xsisqox/Viewnior/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	x11-misc/shared-mime-info"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog* TODO README NEWS || die "dodoc failed"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
