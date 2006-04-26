# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mail-notification/mail-notification-2.0.ebuild,v 1.9 2006/04/26 18:02:18 slarti Exp $

inherit eutils gnome2 multilib flag-o-matic versionator

DESCRIPTION="A GNOME trayicon which checks for mail. Supports mbox, MH,
Maildir, IMAP, Sylpheed, POP3, Gmail and Evolution.  Authenticates via
apop, ssl, sasl."
HOMEPAGE="http://www.nongnu.org/mailnotify/"
SRC_URI="http://savannah.nongnu.org/download/mailnotify/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"

IUSE="imap ipv6 ssl sasl gmail evolution sylpheed mbox maildir pop"

# gmime is actually optional, but it's used by so much of the package it's
# pointless making it optional.
DEPEND=">=x11-libs/gtk+-2.6
	>=dev-util/gob-2
	>=gnome-base/gnome-panel-2.6
	>=gnome-base/eel-2.6
	>=gnome-base/gconf-2.6
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libglade-2.0
	>=gnome-base/orbit-2.6
	>=dev-libs/gmime-2.1
	dev-perl/XML-Parser
	ssl? ( >=dev-libs/openssl-0.9.6 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	evolution? ( >=mail-client/evolution-2.4 )
	sylpheed? ( virtual/sylpheed )"

pkg_setup() {
	if use evolution ; then
		EVO_INSTALLED="$(best_version mail-client/evolution)"
		EVO_INSTALLED="${EVO_INSTALLED##*/}"
		EVO_INSTALLED="${EVO_INSTALLED#*-}"
		EVO_VERSION="$(get_version_component_range 1-2 ${EVO_INSTALLED})"
	fi

	G2CONF="${G2CONF} $(use_enable ssl)"
	G2CONF="${G2CONF} $(use_enable sasl)"
	G2CONF="${G2CONF} $(use_enable ipv6)"
	# ssl, sasl and ipv6 requires either pop3 or imap, else they will be disabled
	G2CONF="${G2CONF} $(use_enable imap)"
	G2CONF="${G2CONF} $(use_enable pop pop3)"
	G2CONF="${G2CONF} $(use_enable gmail)"
	G2CONF="${G2CONF} $(use_enable evolution)"
	G2CONF="${G2CONF} --with-evolution-source-dir=/usr/include/evolution-${EVO_VERSION}"
	G2CONF="${G2CONF} $(use_enable sylpheed)"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	if use evolution ; then
		epatch "${FILESDIR}/${P}-evolution-${EVO_VERSION}.diff"
	fi

	epatch "${FILESDIR}/${P}-buildfix.diff"
	epatch "${FILESDIR}/${P}-gmail-properties-fix.diff"

	gnome2_omf_fix
}

src_compile() {
	append-ldflags -Wl,-export-dynamic
	gnome2_src_compile
}

src_install() {
	gnome2_src_install
	evolution_plugindir="/usr/$(get_libdir)/evolution/${EVO_INSTALLED}/plugins"

	dodoc README NEWS AUTHORS TODO
}

pkg_postinst() {
	ewarn ""
	ewarn "Due to a bug in bonobo-activation, your GNOME/X11 session must"
	ewarn "be restarted for mail-notification to work. If you don't do"
	ewarn "this, this program will crash during the setup phase."
	ewarn "See http://bugzilla.gnome.org/show_bug.cgi?id=151082"
	ewarn ""
}
