# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mail-notification/mail-notification-0.7.0.ebuild,v 1.3 2004/10/17 20:57:01 dholm Exp $

inherit gnome2

DESCRIPTION="A GNOME trayicon which checks for mail supporting mbox, MH,
Maildir, IMAP, Sylpheed, POP3. Authenticates via apop, ssl, sasl."
HOMEPAGE="http://www.nongnu.org/mailnotify/"
SRC_URI="http://savannah.nongnu.org/download/mailnotify/${P}.tar.gz"

KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
LICENSE="GPL-2"

IUSE="imap ipv6 mime ssl sasl"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-util/gob-2
	>=gnome-base/gnome-panel-2
	>=gnome-base/eel-2
	>=gnome-base/gconf-2.4
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/libglade-2.0
	>=gnome-base/eel-2.0
	>=gnome-base/orbit-2.0
	ssl? ( >=dev-libs/openssl-0.9.6 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	mime? ( >=dev-libs/gmime-2 )"

G2CONF="${G2CONF} $(use_enable ssl)"
G2CONF="${G2CONF} $(use_enable sasl)"
G2CONF="${G2CONF} $(use_enable ipv6)"
G2CONF="${G2CONF} $(use_enable imap)"
G2CONF="${G2CONF} $(use_enable mime)"

# Gmail support will be disabled until we're sure it's ok, license-wise	-ticho
G2CONF="${G2CONF} --disable-gmail"

pkg_postinst() {
	echo
	ewarn "Due to a bug in bonobo-activation, your GNOME/X11 session must"
	ewarn "be restarted for mail-notification to work. If you don't do"
	ewarn "this, this program will crash during the setup phase."
	ewarn "See http://bugzilla.gnome.org/show_bug.cgi?id=151082"
	echo
}
