# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-ja/im-ja-0.8.ebuild,v 1.6 2004/03/04 19:21:50 usata Exp $

inherit base gnome2

DESCRIPTION="A Japanese input module for GTK2"
HOMEPAGE="http://im-ja.sourceforge.net/"
SRC_URI="http://im-ja.sourceforge.net/old/${P/_p/-}.tar.gz"
PATCHES1=${FILESDIR}/${PN}-0.6-gentoo.diff
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
SLOT=0
IUSE="gnome canna freewnn"
S=${WORKDIR}/${P/_p*}

DOCS="AUTHORS COPYING README ChangeLog TODO"

DEPEND="virtual/glibc
	>=dev-libs/glib-2.2.1
	>=dev-libs/atk-1.2.2
	>=x11-libs/gtk+-2.2.1
	>=x11-libs/pango-1.2.1
	>=gnome-base/gconf-2.2
	>=gnome-base/libglade-2.0
	gnome? ( >=gnome-base/gnome-panel-2.0 )
	freewnn? ( app-i18n/freewnn )
	canna? ( app-i18n/canna )"

src_compile() {
	local myconf
	use gnome || myconf="$myconf --disable-gnome"
	use canna || myconf="$myconf --disable-canna"
	use freewnn || myconf="$myconf --disable-wnn"
	gnome2_src_compile $myconf
}

pkg_postinst(){
	gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
	gnome2_pkg_postinst
}

pkg_postrm(){
	gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
	gnome2_pkg_postrm
}
