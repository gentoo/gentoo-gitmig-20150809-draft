# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail/claws-mail-3.7.6.ebuild,v 1.6 2010/09/19 16:09:27 armin76 Exp $

EAPI="2"

inherit eutils multilib

DESCRIPTION="An email client (and news reader) based on GTK+"
HOMEPAGE="http://www.claws-mail.org/"

SRC_URI="mirror://sourceforge/sylpheed-claws/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="alpha amd64 hppa ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="bogofilter crypt dbus dillo doc +gnutls +imap ipv6 ldap nntp pda session smime spamassassin spell ssl startup-notification xface"

COMMONDEPEND=">=x11-libs/gtk+-2.6
	pda? ( >=app-pda/jpilot-0.99 )
	ssl? ( >=net-libs/gnutls-2.0.3 )
	ldap? ( >=net-nds/openldap-2.0.7 )
	crypt? ( >=app-crypt/gpgme-0.4.5 )
	dbus? ( >=dev-libs/dbus-glib-0.60 )
	dillo? ( www-client/dillo )
	spell? ( >=app-text/enchant-1.0.0 )
	imap? ( >=net-libs/libetpan-0.57 )
	nntp? ( >=net-libs/libetpan-0.57 )
	gnutls? ( >=net-libs/gnutls-2.0.3 )
	startup-notification? ( x11-libs/startup-notification )
	bogofilter? ( mail-filter/bogofilter )
	session? ( x11-libs/libSM
			x11-libs/libICE )
	smime? ( >=app-crypt/gpgme-0.4.5 )"

DEPEND="${COMMONDEPEND}
	xface? ( >=media-libs/compface-1.4 )
	dev-util/pkgconfig"

RDEPEND="${COMMONDEPEND}
	app-misc/mime-types
	x11-misc/shared-mime-info"

PLUGIN_NAMES="acpi-notifier archive att-remover attachwarner bsfilter cachesaver fancy fetchinfo gtkhtml mailmbox newmail notification perl python rssyl spam_report tnef_parse vcalendar"

src_configure() {
	local myconf
	# libetpan is needed if user wants nntp or imap functionality
	if use imap || use nntp; then
		myconf="--enable-libetpan"
	else
		myconf="--disable-libetpan"
	fi

	# The usage of openssl was discarded once and USE=ssl is mapped to
	# USE=gnutls now.  Maybe USE=ssl can fade out sometime
	if use ssl || use gnutls; then
		myconf="${myconf} --enable-gnutls"
	else
		myconf="${myconf} --disable-gnutls"
	fi

	econf \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		$(use_enable dbus) \
		$(use_enable pda jpilot) \
		$(use_enable spell enchant) \
		$(use_enable xface compface) \
		$(use_enable doc manual) \
		$(use_enable startup-notification) \
		$(use_enable session libsm) \
		$(use_enable crypt pgpmime-plugin) \
		$(use_enable crypt pgpinline-plugin) \
		$(use_enable crypt pgpcore-plugin) \
		$(use_enable dillo dillo-viewer-plugin) \
		$(use_enable spamassassin spamassassin-plugin) \
		$(use_enable bogofilter bogofilter-plugin) \
		$(use_enable smime smime-plugin) \
		--docdir=/usr/share/doc/${PF} \
		--enable-trayicon-plugin \
		--disable-maemo ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die

	# Makefile install claws-mail.png in /usr/share/icons/hicolor/48x48/apps
	# => also install it in /usr/share/pixmaps for other desktop envs
	# => also install higher resolution icons in /usr/share/icons/hicolor/...
	insinto /usr/share/pixmaps
	doins ${PN}.png || die
	local res resdir
	for res in 64x64 128x128 ; do
		resdir="/usr/share/icons/hicolor/${res}/apps"
		insinto ${resdir}
		newins ${PN}-${res}.png ${PN}.png || die
	done

	dodoc AUTHORS ChangeLog* INSTALL* NEWS README* TODO*
	docinto tools
	dodoc tools/README*

	insinto /usr/share/applications
	doins ${PN}.desktop

	einfo "Installing extra tools"
	cd "${S}"/tools
	exeinto /usr/$(get_libdir)/${PN}/tools
	doexe *.pl *.py *.conf *.sh || die
	doexe tb2claws-mail update-po uudec uuooffice || die

	# kill useless plugin files
	rm -f "${D}"/usr/lib*/${PN}/plugins/*.{la,a}
}

pkg_postinst() {
	gtk-update-icon-cache -f -t "${ROOT}"/usr/share/icons/hicolor

	UPDATE_PLUGINS=""
	for x in ${PLUGIN_NAMES}; do
		has_version mail-client/${PN}-$x && UPDATE_PLUGINS="${UPDATE_PLUGINS} $x"
	done
	if [ -n "${UPDATE_PLUGINS}" ]; then
		elog
		elog "You have to re-emerge or update the following plugins:"
		elog
		for x in ${UPDATE_PLUGINS}; do
			elog "    mail-client/${PN}-$x"
		done
		elog
	fi
}

pkg_postrm() {
	gtk-update-icon-cache -f -t "${ROOT}"/usr/share/icons/hicolor
}
