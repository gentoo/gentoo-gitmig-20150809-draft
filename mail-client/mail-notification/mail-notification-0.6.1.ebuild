# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mail-notification/mail-notification-0.6.1.ebuild,v 1.5 2004/09/09 19:58:00 slarti Exp $

inherit gnome2 eutils 64-bit

DESCRIPTION="A full-featured GNOME trayicon that checks for mail supporting
mbox, MH, Maildir, IMAP, Sylpheed, POP3. Authenticates via apop, ssl, sasl."
HOMEPAGE="http://www.nongnu.org/mailnotify/"
SRC_URI="http://savannah.nongnu.org/download/mailnotify/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"

IUSE="imap ipv6 ssl sasl"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-util/gob-2
	>=gnome-base/gnome-panel-2
	>=gnome-base/eel-2
	ssl? ( >=dev-libs/openssl-0.9.6 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )"

G2CONF="${G2CONF} $(use_enable ssl)"
G2CONF="${G2CONF} $(use_enable sasl)"
G2CONF="${G2CONF} $(use_enable ipv6)"
G2CONF="${G2CONF} $(use_enable imap)"

# Gmail support will be disabled until we're sure it's ok, license-wise	-ticho
G2CONF="${G2CONF} --disable-gmail"

src_unpack() {
	unpack ${A}
	cd ${S}
	64-bit && epatch ${FILESDIR}/${P}-64bit-fix.patch
}

pkg_postinst() {
	echo
	ewarn "You need to restart your GNOME/X11 session for mail-notification"
	ewarn "to work. If you don't do this, this program will crash during the"
	ewarn "setup phase."
	ewarn "See http://bugzilla.gnome.org/show_bug.cgi?id=151082"
	echo
}
