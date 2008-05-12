# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail/claws-mail-3.4.0.ebuild,v 1.1 2008/05/12 10:22:54 opfer Exp $

inherit eutils multilib

DESCRIPTION="An email client (and news reader) based on GTK+"
HOMEPAGE="http://www.claws-mail.org/"

SRC_URI="mirror://sourceforge/sylpheed-claws/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="bogofilter crypt dillo doc gnome gnutls imap ipv6 kde ldap nntp pda session spamassassin spell ssl startup-notification xface"

COMMONDEPEND=">=x11-libs/gtk+-2.6
	pda? ( >=app-pda/jpilot-0.99 )
	ssl? ( >=dev-libs/openssl-0.9.7 )
	ldap? ( >=net-nds/openldap-2.0.7 )
	crypt? ( >=app-crypt/gpgme-1.1.1 )
	dillo? ( www-client/dillo )
	spell? ( virtual/aspell-dict )
	kde? ( kde-base/kdelibs )
	imap? ( >=net-libs/libetpan-0.49 )
	nntp? ( >=net-libs/libetpan-0.49 )
	gnome? ( >=gnome-base/libgnomeprintui-2.2 )
	gnutls? ( net-libs/gnutls )
	startup-notification? ( x11-libs/startup-notification )
	bogofilter? ( mail-filter/bogofilter )
	session? ( x11-libs/libSM
			x11-libs/libICE )"

DEPEND="${COMMONDEPEND}
	xface? ( >=media-libs/compface-1.4 )
	>=sys-apps/sed-4
	dev-util/pkgconfig"

RDEPEND="${COMMONDEPEND}
	app-misc/mime-types
	x11-misc/shared-mime-info"

PLUGIN_NAMES="acpi-notifier att-remover attachwarner cachesaver etpan-privacy fetchinfo gtkhtml maildir mailmbox newmail notification pdf-viewer perl rssyl smime synce vcalendar"

src_compile() {
	local myconf="--disable-libetpan"

	# libetpan is needed if user wants nntp or imap functionality
	# TODO: Perhaps change it into a single "libetpan" USE flag?
	use imap && myconf="--enable-libetpan"
	use nntp && myconf="--enable-libetpan"

	# Optional features
	myconf="${myconf} `use_enable gnome gnomeprint`"
	myconf="${myconf} `use_enable ipv6`"
	myconf="${myconf} `use_enable ldap`"
	myconf="${myconf} `use_enable pda jpilot`"
	myconf="${myconf} `use_enable spell aspell`"
	myconf="${myconf} `use_enable gnutls`"
	myconf="${myconf} `use_enable ssl openssl`"
	myconf="${myconf} `use_enable xface compface`"
	myconf="${myconf} `use_enable doc manual`"
	myconf="${myconf} `use_enable startup-notification`"
	myconf="${myconf} `use_enable session libsm`"

	# Optional plugins
	myconf="${myconf} `use_enable crypt pgpmime-plugin`"
	myconf="${myconf} `use_enable crypt pgpinline-plugin`"
	myconf="${myconf} `use_enable crypt pgpcore-plugin`"
	myconf="${myconf} `use_enable dillo dillo-viewer-plugin`"
	myconf="${myconf} `use_enable spamassassin spamassassin-plugin`"
	myconf="${myconf} `use_enable bogofilter bogofilter-plugin`"

	econf \
		--enable-trayicon-plugin \
		--disable-maemo \
		${myconf} || die "./configure failed"

	emake || die
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

	if use kde; then
		einfo "Installing kde service scripts"
		local kdeprefix="$(kde-config --prefix)"
		local servicescript="${PN}-kdeservicemenu.pl"
		local desktopfile="${PN}-attach-files.desktop"
		cd "${S}"/tools/kdeservicemenu
		sed -i -e "s:SCRIPT_PATH:${kdeprefix}/bin/${servicescript}:g" \
			${desktopfile}.template
		dodir /usr/share/apps/konqueror/servicemenus
		insopts -m 0644
		insinto /usr/share/apps/konqueror/servicemenus
		newins ${desktopfile}.template ${desktopfile} || die
		dodir ${kdeprefix}/bin
		insopts -m 755
		exeinto ${kdeprefix}/bin
		doexe ${servicescript} || die
	fi

	# kill useless plugin files
	rm -f "${D}"/usr/lib*/${PN}/plugins/*.{la,a}
}

pkg_postinst() {
	gtk-update-icon-cache -f -t "${ROOT}"/usr/share/icons/hicolor

	UPDATE_PLUGINS=""
	RENAME_PLUGINS=""
	for x in ${PLUGIN_NAMES}; do
		has_version mail-client/${PN}-$x && UPDATE_PLUGINS="${UPDATE_PLUGINS} $x"
		has_version mail-client/sylpheed-claws-$x && RENAME_PLUGINS="${RENAME_PLUGINS} $x"
	done
	if [ -n "${RENAME_PLUGINS}" ]; then
		elog
		elog "The following sylpheed-claws plugins were found on your system:"
		elog
		for x in ${RENAME_PLUGINS}; do
			elog "    mail-client/sylpheed-claws-$x"
		done
		elog
		elog "If you want to continue using those you need to merge their "
		elog "renamed counterparts:"
		elog
		for x in ${RENAME_PLUGINS}; do
			elog "    mail-client/${PN}-$x"
		done
		elog
	fi
	if [ -n "${UPDATE_PLUGINS}" ]; then
		elog
		elog "You have to re-emerge or update the following plugins:"
		elog
		for x in ${UPDATE_PLUGINS}; do
			elog "    mail-client/${PN}-$x"
		done
		elog
	fi
	if [ -n "${RENAME_PLUGINS}${UPDATE_PLUGINS}" ]; then
		elog
		elog "You can use"
		elog "    /bin/bash ${FILESDIR}/plugins-rebuild.sh"
		elog "to automatically handle this."
		elog
		epause 5
		ebeep 3
	fi
}

pkg_postrm() {
	gtk-update-icon-cache -f -t "${ROOT}"/usr/share/icons/hicolor
}
