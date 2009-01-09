# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/glabels/glabels-2.2.3.ebuild,v 1.4 2009/01/09 17:49:51 ranger Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://glabels.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
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

src_unpack() {
	gnome2_src_unpack

	# Fix missing pkg-config macro (bug #204276)
	# https://sourceforge.net/tracker/index.php?func=detail&aid=2316013&group_id=46122&atid=445116
	epatch "${FILESDIR}/${PN}-2.2.1-pkg-config-macro.patch"

	# Intltool tests fixes
	echo "data/templates/dymo-other-templates.xml" >> po/POTFILES.in
	echo "libglabels/db.c" >> po/POTFILES.in

	intltoolize --force || die "intltoolize failed"
	eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst

	ewarn "As of 2.2.0, glabels had a file format change. Files will be"
	ewarn "automatically converted to the new format but it is a one way"
	ewarn "process only. Make backups."
}
