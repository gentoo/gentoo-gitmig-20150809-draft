# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-ja/im-ja-0.9-r1.ebuild,v 1.5 2004/04/06 03:53:32 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="A Japanese input module for GTK2 and XIM"
HOMEPAGE="http://im-ja.sourceforge.net/"
SRC_URI="http://im-ja.sourceforge.net/${P}.tar.gz
	http://im-ja.sourceforge.net/old/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="gnome canna freewnn debug"

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
	canna? ( app-i18n/canna )"

DOCS="AUTHORS README ChangeLog TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-canna-3.7-gentoo.diff
	# fix for the bug #45246
	if has_version '>=x11-libs/gtk+-2.4' ; then
		use debug || find . -name 'Makefile*' \
			-exec sed -i -e "/DEPRECATED/d" {} \;
		cd src
		epatch ${FILESDIR}/${P}-gtk24-gentoo.diff
	fi
}

src_compile() {
	local myconf
	export WANT_AUTOMAKE=1.8
	use gnome || myconf="$myconf --disable-gnome"
	use canna || myconf="$myconf --disable-canna"
	use freewnn || myconf="$myconf --disable-wnn"
	use debug && myconf="$myconf --enable-debug"
	gnome2_src_compile $myconf
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
