# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/glabels/glabels-2.2.2.ebuild,v 1.2 2008/03/20 20:12:24 eva Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://glabels.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
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
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_with eds libebook)
		--disable-update-mimedb
		--disable-update-desktopdb"
}

src_unpack() {
	gnome2_src_unpack

	# Fix missing pkg-config macro (bug 204276)
	epatch "${FILESDIR}/${PN}-2.2.1-pkg-config-macro.patch"

	# drop gtk-doc for eautoreconf
	use doc || epatch "${FILESDIR}/${PN}-2.2.1-drop-gtk-doc.patch"

	eautoreconf
	intltoolize --force || die "intltoolize failed"
}

pkg_postinst() {
	gnome2_pkg_postinst

	ewarn "This version of ${PN} has a file format change. Files will be"
	ewarn "automatically converted to the new format but it is a one way"
	ewarn "process only. Make backups."
}
