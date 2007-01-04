# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.11-r1.ebuild,v 1.1 2007/01/04 22:36:58 welp Exp $

inherit multilib python

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="dbus gnome idle libnotify nls spell srv trayicon X xhtml"

DEPEND="dev-python/pysqlite
	dev-python/pygtk
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

RDEPEND="gnome? ( dev-python/gnome-python-extras dev-python/gnome-python-desktop )
	dbus? ( sys-apps/dbus )
	dbus? ( libnotify? ( x11-libs/libnotify ) )
	xhtml? ( dev-python/docutils )
	srv? ( net-dns/bind-tools )
	idle? ( x11-libs/libXScrnSaver )
	spell? ( app-text/gtkspell )
	avahi? ( net-dns/avahi )"

pkg_setup() {
	if use dbus && !build_with_use sys-apps/dbus python; then
		eerror "Please rebuild dbus with USE=\"python\"."
		die "Python D-Bus support missing"
	fi
}

src_compile() {
	econf \
		$(use_enable nls ) \
		$(use_enable spell gtkspell ) \
		$(use_enable dbus remote ) \
		$(use_with X x ) \
		die || "Configure failed"
	if !use gnome; then
		econf \
			$(use_enable trayicon ) \
			$(use_enable idle ) \
			die || "Configure failed"
	fi
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" LIBDIR=/$(get_libdir) install || die "Install failed"
	dodoc README NEWS AUTHORS ChangeLog THANKS
}

pkg_postinst() {
	python_mod_optimize /usr/share/gajim/
}
pkg_postrm() {
	python_mod_cleanup /usr/share/gajim/
}
