# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gucharmap/gucharmap-1.2.0.ebuild,v 1.6 2004/01/29 05:02:27 agriffis Exp $

inherit gnome2 eutils

DESCRIPTION="Unicode charachter map viewer"
HOMEPAGE="http://gucharmap.sourceforge.net/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc hppa ~amd64 ia64"
IUSE="gnome cjk"

RDEPEND=">=x11-libs/gtk+-2.2
	dev-libs/popt
	gnome? ( >=gnome-base/libgnome-2.2
		 >=gnome-base/libgnomeui-2.2 )
	!<gnome-extra/gnome-utils-2.3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} $(use_enable gnome) $(use_enable cjk unihan) --disable-gtk-immodules"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gcc2_fix.patch
}

pkg_postinst() {

	einfo "Registering GTK+ input modules..."
	${ROOT}/usr/bin/gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules

}

pkg_postrm() {

	einfo "Registering GTK+ input modules..."
	${ROOT}/usr/bin/gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules

}
