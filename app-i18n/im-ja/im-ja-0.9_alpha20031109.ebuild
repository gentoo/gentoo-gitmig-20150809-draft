# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-ja/im-ja-0.9_alpha20031109.ebuild,v 1.1 2003/12/13 15:26:07 usata Exp $

inherit base gnome2

MY_P="${PN}-0.8"

DESCRIPTION="A Japanese input module for GTK2"
HOMEPAGE="http://im-ja.sourceforge.net/"
# This snapshot was taken from
#	http://siliconium.net/~boti/im-ja/im-ja-0.8.tar.gz
SRC_URI="mirror://gentoo/${P/_/-}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P/_/-}.tar.gz"
#SRC_URI="${HOMEPAGE}${P/_p/-}.tar.gz
#	${HOMEPAGE}old/${P/_p/-}.tar.gz"
PATCHES1=${FILESDIR}/${PN}-0.6-gentoo.diff
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"
IUSE="gnome canna freewnn"

S=${WORKDIR}/${MY_P}

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
	einfo
	einfo "This preview comes with experimental XIM support."
	einfo "If you'd like to try it out, run im-ja-xim-server and set"
	einfo "environment variable XMODIFIERS to @im=im-ja-xim-server"
	einfo "e.g.)"
	einfo "\t$ export XMODIFIERS=@im=im-ja-xim-server (sh)"
	einfo "\t> setenv XMODIFIERS @im=im-ja-xim-server (csh)"
	einfo
}

pkg_postrm(){
	gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
	gnome2_pkg_postrm
}
