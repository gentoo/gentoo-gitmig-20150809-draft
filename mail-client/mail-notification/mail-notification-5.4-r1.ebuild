# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mail-notification/mail-notification-5.4-r1.ebuild,v 1.5 2009/05/05 05:40:19 jer Exp $

inherit gnome2 multilib flag-o-matic toolchain-funcs

DESCRIPTION="A GNOME trayicon which checks for email, with support for many online and offline mailbox formats."
HOMEPAGE="http://www.nongnu.org/mailnotify/"
SRC_URI="http://savannah.nongnu.org/download/mailnotify/${P}.tar.bz2"

KEYWORDS="amd64 hppa ppc sparc x86"
SLOT="0"
LICENSE="GPL-3"

IUSE="evo gmail imap ipv6 maildir mbox mh mozilla pop sasl ssl sylpheed"

# gmime is actually optional, but it's used by so much of the package
# it's pointless making it optional. gnome-keyring is required for
# several specific access methods, and thus linked to those USE flags
# instead of adding a keyring USE flag.
RDEPEND=">=x11-libs/gtk+-2.12
	>=dev-libs/glib-2.14
	>=gnome-base/gconf-2.4.0
	>=gnome-base/gnome-panel-2.6
	>=gnome-base/eel-2.6
	>=gnome-base/gconf-2.6
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/libglade-2.0
	dev-libs/dbus-glib
	>=dev-libs/gmime-2.2.7
	=dev-libs/gmime-2.2*
	>=x11-libs/libnotify-0.4.1
	pop? ( gnome-base/gnome-keyring )
	imap? ( gnome-base/gnome-keyring )
	gmail? ( gnome-base/gnome-keyring )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	evo? ( >=mail-client/evolution-2.24 )
	sylpheed? ( virtual/sylpheed )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.0"

# this now uses JB (the Jean-Yves Lefort's Build System) as a build system
# instead of autotools, this is a little helper function that basically does
# the same thing as use_enable
use_var() {
	echo -n "${2:-$1}="
	use "${1}" && echo "yes" || echo "no"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-dont-update-cache.patch"

	# We are not Ubuntu, and I suspect that this is the cause of #215281
	epatch "${FILESDIR}/${P}-remove-ubuntu-special-case.patch"

	# Make sure we don't crash with newer versions of
	# evolution-data-server.
	epatch "${FILESDIR}/${P}-e-d-s-2.24.patch"
}

src_compile() {
	./jb configure destdir="${D}" prefix="/usr" libdir=/usr/$(get_libdir) \
		sysconfdir="/etc" localstatedir="/var" cc="$(tc-getCC)" \
		cflags="${CFLAGS}" cppflags="${CXXFLAGS}" ldflags="${LDFLAGS}" \
		scrollkeeper-dir="/var/lib/scrollkeeper" \
		$(use_var evo evolution) \
		$(use_var gmail) \
		$(use_var imap) \
		$(use_var ipv6) \
		$(use_var maildir) \
		$(use_var mbox) \
		$(use_var mh) \
		$(use_var mozilla) \
		$(use_var pop pop3) \
		$(use_var sasl) \
		$(use_var ssl) \
		$(use_var sylpheed)

	./jb build
}

src_install() {
	GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1" ./jb install

	dodoc NEWS README AUTHORS TODO TRANSLATING

	rm -rf "${D}/var/lib/scrollkeeper"
}
