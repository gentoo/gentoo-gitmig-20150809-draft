# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.10.1.ebuild,v 1.11 2007/01/06 00:04:22 welp Exp $

inherit virtualx multilib eutils

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc sparc x86"
IUSE="dbus gnome libnotify nls spell srv"

RDEPEND="!<=dev-python/gnome-python-2
	>=dev-python/pygtk-2.8.2
	>=dev-python/pysqlite-2.0.5
	dbus? ( >=sys-apps/dbus-0.60 )
	gnome? ( >=dev-python/gnome-python-extras-2.10 )
	libnotify? ( x11-misc/notification-daemon )
	srv? ( net-dns/bind-tools )"

DEPEND="dev-util/intltool
	dev-util/pkgconfig
	!gnome? ( spell? ( >=app-text/gtkspell-2.0.11 ) )
	input_devices_keyboard? ( x11-libs/libXScrnSaver )"

pkg_setup() {
	if use dbus && ! built_with_use sys-apps/dbus python; then
		eerror "Please rebuild dbus with USE=\"python\"."
		die "Python D-bus support missing."
	fi

	if use libnotify && ! use dbus; then
		eerror "With libnotify useflag, you must also enable dbus useflag."
		die "Please enable dbus useflag."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gajim-10.1-Makefile.patch
}

src_compile() {
	targets="idle gajim.desktop"
	! use gnome && targets="${targets} trayicon"
	use nls && targets="${targets} translation"
	! use gnome && use spell && targets="${targets} gtkspell"
	Xemake ${targets} || die "Xemake failed"
}

src_install() {
	Xemake PREFIX=/usr DESTDIR=${D} LIBDIR=/$(get_libdir) install || die
	dodoc README AUTHORS COPYING Changelog
}

pkg_postinst() {
	if use amd64; then
		ewarn
		ewarn "Because of an unresolved segmentation fault,"
		ewarn "amd64 users must probably upgrade to gcc >= 4.0.2,"
		ewarn "and rebuild the following packages :"
		ewarn " - x11-libs/gtk+"
		ewarn " - dev-python/pygtk"
		ewarn " - dev-lang/python"
		ewarn
		ewarn "Please see bug #109298."
		ewarn
	fi
}
