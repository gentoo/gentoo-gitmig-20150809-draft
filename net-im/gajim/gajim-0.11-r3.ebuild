# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.11-r3.ebuild,v 1.3 2007/01/06 08:28:34 antarus Exp $

inherit multilib python eutils

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
	dbus? ( ||
		( >=sys-apps/dbus-0.90 dev-python/dbus-python dev-libs/dbus-glib )
		( <sys-apps/dbus-0.90 )
	)
	libnotify? ( x11-libs/libnotify )
	xhtml? ( dev-python/docutils )
	srv? ( net-dns/bind-tools )
	idle? ( x11-libs/libXScrnSaver )
	spell? ( app-text/gtkspell )
	avahi? ( net-dns/avahi )"

pkg_setup() {
	if ! use dbus; then
		if use libnotify; then
			eerror "The dbus USE flag is required for libnotify support"
			die "USE=\"dbus\" needed for libnotify support"
		fi
		if use avahi; then
			eerror "The dbus USE flag is required for avahi support"
			die "USE=\"dbus\" needed for avahi support"
		fi
	else
		if has_version "<sys-apps/dbus-0.90" && ! built_with_use sys-apps/dbus python; then
				eerror "Please rebuild dbus with USE=\"python\""
				die "USE=\"python\" needed for dbus"
		fi
	fi

	if use avahi; then
		if ! built_with_use net-dns/avahi dbus gtk python; then
			eerror "The following USE flags are required for correct avahi"
			eerror "support: dbus gtk python"
			die "Please rebuild avahi with these use flags enabled."
		fi
	fi
}

src_compile() {
	local myconf
	if ! use gnome; then
		myconf="${myconf} $(use_enable trayicon)"
		myconf="${myconf} $(use_enable idle)"
	fi

	econf $(use_enable nls) \
		$(use_enable spell gtkspell) \
		$(use_enable dbus remote) \
		$(use_with X x) \
		${myconf} || die "econf failed"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || \
		die "emake install failed"
	dodoc README NEWS AUTHORS ChangeLog THANKS
}

pkg_postinst() {
	python_mod_optimize /usr/share/gajim/
}
pkg_postrm() {
	python_mod_cleanup /usr/share/gajim/
}
