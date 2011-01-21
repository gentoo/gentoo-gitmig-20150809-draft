# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leafpad/leafpad-0.8.18.1.ebuild,v 1.1 2011/01/21 16:49:36 ssuominen Exp $

EAPI=3
inherit fdo-mime gnome2-utils

DESCRIPTION="Simple GTK+ Text Editor"
HOMEPAGE="http://tarot.freeshell.org/leafpad/"
SRC_URI="http://savannah.nongnu.org/download/leafpad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="emacs"

RDEPEND=">=x11-libs/gtk+-2.10:2
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-chooser \
		--enable-print \
		$(use_enable emacs)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
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
