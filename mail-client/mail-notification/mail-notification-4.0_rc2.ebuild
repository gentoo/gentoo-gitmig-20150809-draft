# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mail-notification/mail-notification-4.0_rc2.ebuild,v 1.4 2007/08/30 16:08:54 pva Exp $

inherit eutils gnome2 multilib flag-o-matic versionator

MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="A GNOME trayicon which checks for email. Supports mbox, MH,
Maildir, IMAP, Sylpheed, POP3, Gmail and Evolution.  Authenticates via
apop, ssl, sasl."
HOMEPAGE="http://www.nongnu.org/mailnotify/"
SRC_URI="http://savannah.nongnu.org/download/mailnotify/${PN}-${MY_PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"

IUSE="imap ipv6 ssl sasl gmail evo sylpheed mbox maildir pop mozilla"

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
	evo? ( >=mail-client/evolution-2.6 )
	sylpheed? ( virtual/sylpheed )"

S="${WORKDIR}/${P/_/-}"

pkg_setup() {
	if use evo ; then
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
	G2CONF="${G2CONF} $(use_enable evo evolution)"
	G2CONF="${G2CONF} --with-evolution-source-dir=/usr/include/evolution-${EVO_VERSION}"
	G2CONF="${G2CONF} $(use_enable sylpheed)"
	G2CONF="${G2CONF} $(use_enable mozilla)"
}

src_unpack() {
	gnome2_src_unpack
	gnome2_omf_fix

	sed -i -e 's:gtk-update-icon-cache:true:' ./art/Makefile.in
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
