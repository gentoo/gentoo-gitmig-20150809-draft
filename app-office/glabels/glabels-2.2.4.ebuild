# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/glabels/glabels-2.2.4.ebuild,v 1.6 2010/05/26 20:37:29 eva Exp $

inherit gnome2

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://glabels.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="sparc"
IUSE="doc eds"

RDEPEND=">=dev-libs/glib-2.12
	>=x11-libs/gtk+-2.10
	>=gnome-base/libgnome-2.16
	>=gnome-base/libgnomeui-2.16
	>=dev-libs/libxml2-2.6
	>=gnome-base/libglade-2.6
	eds? ( >=gnome-extra/evolution-data-server-1.8 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper
	>=dev-util/intltool-0.28
	dev-util/gtk-doc-am
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_with eds libebook)
		--disable-update-mimedb
		--disable-update-desktopdb"
}

pkg_postinst() {
	gnome2_pkg_postinst

	ewarn "As of 2.2.0, glabels had a file format change. Files will be"
	ewarn "automatically converted to the new format but it is a one way"
	ewarn "process only. Make backups."
}
