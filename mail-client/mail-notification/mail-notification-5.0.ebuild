# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mail-notification/mail-notification-5.0.ebuild,v 1.10 2008/05/03 06:19:13 graaff Exp $

inherit autotools eutils gnome2 multilib flag-o-matic versionator

DESCRIPTION="A GNOME trayicon which checks for email. Supports mbox, MH,
Maildir, IMAP, Sylpheed, POP3, Gmail and Evolution.  Authenticates via
apop, ssl, sasl."
HOMEPAGE="http://www.nongnu.org/mailnotify/"
SRC_URI="http://savannah.nongnu.org/download/mailnotify/${P}.tar.bz2"

KEYWORDS="amd64 hppa ppc sparc x86"
SLOT="0"
LICENSE="GPL-3"

IUSE="imap ipv6 ssl sasl gmail evo sylpheed mbox maildir pop mozilla"

# tests are currently broken and officially not supported upstream:
# https://bugs.launchpad.net/mail-notification/+bug/182234
RESTRICT="test"

# gmime is actually optional, but it's used by so much of the package
# it's pointless making it optional. gnome-keyring is required for
# several specific access methods, and thus linked to those USE flags
# instead of adding a keyring USE flag.
RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.10
	>=gnome-base/gnome-panel-2.6
	>=gnome-base/eel-2.6
	>=gnome-base/gconf-2.6
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/libglade-2.0
	>=gnome-base/orbit-2.6
	>=gnome-base/libbonobo-2.0
	>=dev-libs/gmime-2.1
	>=x11-libs/libnotify-0.4.1
	pop? ( gnome-base/gnome-keyring )
	imap? ( gnome-base/gnome-keyring )
	gmail? ( gnome-base/gnome-keyring )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	evo? ( >=mail-client/evolution-2.12 )
	sylpheed? ( virtual/sylpheed )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.0"

DOCS="README NEWS AUTHORS TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable ssl)"
	G2CONF="${G2CONF} $(use_enable sasl)"
	G2CONF="${G2CONF} $(use_enable ipv6)"
	# ssl, sasl and ipv6 requires either pop3 or imap, else they will be disabled
	G2CONF="${G2CONF} $(use_enable imap)"
	G2CONF="${G2CONF} $(use_enable pop pop3)"
	G2CONF="${G2CONF} $(use_enable gmail)"
	G2CONF="${G2CONF} $(use_enable evo evolution)"
	G2CONF="${G2CONF} $(use_enable sylpheed)"
	G2CONF="${G2CONF} $(use_enable mozilla)"
}

src_unpack() {
	gnome2_src_unpack

	sed -i -e 's:gtk-update-icon-cache:true:' ./art/Makefile.in
}

src_compile() {
	append-ldflags -Wl,-export-dynamic
	gnome2_src_compile
}
