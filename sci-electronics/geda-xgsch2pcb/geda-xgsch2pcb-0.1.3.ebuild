# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda-xgsch2pcb/geda-xgsch2pcb-0.1.3.ebuild,v 1.2 2011/03/02 21:16:07 jlec Exp $

EAPI="2"

WANT_AUTOCONF="2.5"

inherit autotools fdo-mime gnome2-utils

DESCRIPTION="A graphical front-end for the gschem -> pcb workflow"
HOMEPAGE="http://www.gpleda.org/tools/xgsch2pcb/index.html"
SRC_URI="http://geda.seul.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome nls"

CDEPEND="
	<dev-lang/python-3
	dev-python/pygtk:2
	dev-python/pygobject:2
	dev-python/dbus-python
	sci-electronics/pcb[dbus]
	sci-electronics/geda
	nls? ( virtual/libintl )"

RDEPEND="
	${CDEPEND}
	sci-electronics/electronics-menu
	gnome? ( dev-python/gnome-python )"

DEPEND="
	${CDEPEND}
	dev-util/intltool
	dev-lang/perl
	nls? ( sys-devel/gettext )"

src_prepare(){
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		--disable-update-desktop-database \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
