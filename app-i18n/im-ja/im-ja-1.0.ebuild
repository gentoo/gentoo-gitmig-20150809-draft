# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-ja/im-ja-1.0.ebuild,v 1.1 2004/03/24 17:31:42 usata Exp $

inherit gnome2

IUSE="gnome canna freewnn skk anthy debug"

DESCRIPTION="A Japanese input module for GTK2 and XIM"
HOMEPAGE="http://im-ja.sourceforge.net/"
SRC_URI="http://im-ja.sourceforge.net/${P}.tar.gz
	http://im-ja.sourceforge.net/old/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"

S=${WORKDIR}/${P}

DOCS="AUTHORS README ChangeLog TODO"

DEPEND="dev-lang/perl
	dev-perl/URI
	${RDEPEND}"
RDEPEND="virtual/glibc
	>=dev-libs/glib-2.2.1
	>=dev-libs/atk-1.2.2
	>=x11-libs/gtk+-2.2.1
	>=x11-libs/pango-1.2.1
	>=gnome-base/gconf-2.2
	>=gnome-base/libglade-2.0
	gnome? ( >=gnome-base/gnome-panel-2.0 )
	freewnn? ( app-i18n/freewnn )
	canna? ( app-i18n/canna )
	skk? ( virtual/skkserv )
	anthy? ( || ( app-i18n/anthy app-i18n/anthy-ss ) )"

use debug && RESTRICT="nostrip"

src_compile() {
	local myconf
	# You cannot use `use_enable ...` here. im-ja's configure script
	# doesn't distinguish --enable-canna from --disable-canna, so
	# --enable-canna stands for --disable-canna in the script ;-(
	use gnome || myconf="$myconf --disable-gnome"
	use canna || myconf="$myconf --disable-canna"
	use freewnn || myconf="$myconf --disable-wnn"
	use anthy || myconf="$myconf --disable-anthy"
	use skk || myconf="$myconf --disable-skk"
	use debug && myconf="$myconf --enable-debug"
	gnome2_src_compile --enable-xim || die
}

pkg_postinst(){
	gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
	gnome2_pkg_postinst
	einfo
	einfo "This version of im-ja comes with experimental XIM support."
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
