# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws/sylpheed-claws-2.0.0.ebuild,v 1.1 2006/02/10 18:06:18 genone Exp $

IUSE="gnome dillo crypt spell ssl ldap ipv6 pda clamav xface kde imap spamassassin doc"

inherit eutils

DESCRIPTION="Bleeding edge version of Sylpheed"
HOMEPAGE="http://claws.sylpheed.org"

if [ -n "${P/*_rc*/}" ]; then
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
else
	MY_P="${P/_/-}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="http://claws.sylpheed.org/snapshots/${MY_P}.tar.bz2"
fi

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"

COMMONDEPEND=">=x11-libs/gtk+-2.4
	pda? ( >=app-pda/jpilot-0.99 )
	ssl? ( >=dev-libs/openssl-0.9.7 )
	ldap? ( >=net-nds/openldap-2.0.7 )
	crypt? ( >=app-crypt/gpgme-0.4 )
	dillo? ( www-client/dillo )
	spell? ( virtual/aspell-dict )
	clamav? ( app-antivirus/clamav )
	kde? ( kde-base/kdelibs )
	imap? ( >=net-libs/libetpan-0.41 )
	gnome? ( >=gnome-base/libgnomeprintui-2.2 )
	x11-libs/startup-notification
	!mail-client/sylpheed-claws-pgpinline"	# included in the main package now

DEPEND="${COMMONDEPEND}
	xface? ( >=media-libs/compface-1.4 )
	>=sys-apps/sed-4"

RDEPEND="${COMMONDEPEND}
	app-misc/mime-types
	net-mail/metamail
	x11-misc/shared-mime-info"

PROVIDE="virtual/sylpheed"

src_unpack() {
	unpack ${A}

	# Only install local manual/FAQ if USE=doc, and honor $LINGUAS:
	local docdir lang languages
	for docdir in faq manual ; do
		cd "${S}/doc/${docdir}"
		languages=""
		# filter languages that are in $LINGUAS
		for lang in ${LINGUAS} ; do
			if [[ -d "${lang}" ]] ; then
				languages="${languages} ${lang}"
			fi
		done
		# Fix SUBDIRS (will be empty if -doc)
		if use doc && [ -n "${languages}" ]; then
			sed -i -e "/^SUBDIRS =/s:= .*:= ${languages}:" Makefile.in
		elif ! use doc; then
			sed -i -e "/^SUBDIRS =/s:= .*:= :" Makefile.in
		fi
	done
}

src_compile() {
	local myconf

	# Optional features
	myconf="${myconf} `use_enable gnome gnomeprint`"
	myconf="${myconf} `use_enable imap libetpan`"
	myconf="${myconf} `use_enable ipv6`"
	myconf="${myconf} `use_enable ldap`"
	myconf="${myconf} `use_enable pda jpilot`"
	myconf="${myconf} `use_enable spell aspell`"
	myconf="${myconf} `use_enable ssl openssl`"
	myconf="${myconf} `use_enable xface compface`"

	# Optional plugins
	myconf="${myconf} `use_enable clamav clamav-plugin`"
	myconf="${myconf} `use_enable crypt pgpmime-plugin`"
	myconf="${myconf} `use_enable crypt pgpinline-plugin`"
	myconf="${myconf} `use_enable crypt pgpcore-plugin`"
	myconf="${myconf} `use_enable dillo dillo-viewer-plugin`"
	myconf="${myconf} `use_enable spamassassin spamassassin-plugin`"

	econf \
		--enable-startup-notification \
		--enable-trayicon-plugin \
		${myconf} || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# wait for upstream: move manpage
	mv ${D}/usr/share/man/man1/sylpheed{,-claws}.1

	dodir /usr/share/applications
	mv ${D}/usr/share/{gnome/apps/Internet,applications}/sylpheed-claws.desktop
	rm -rf ${D}/usr/share/gnome

	# Makefile install sylpheed-claws.png in /usr/share/icons/hicolor/48x48/apps
	# => also install it in /usr/share/pixmaps for other desktop envs
	# => also install higher resolution icons in /usr/share/icons/hicolor/...
	insinto /usr/share/pixmaps
	doins sylpheed-claws.png
	local res resdir
	for res in 64x64 128x128 ; do
		resdir="/usr/share/icons/hicolor/${res}/apps"
		insinto ${resdir}
		newins sylpheed-claws-${res}.png sylpheed-claws.png
	done

	dodoc AUTHORS ChangeLog* INSTALL* NEWS README* TODO*
	docinto tools
	dodoc tools/README*

	# install the extra tools
	cd ${S}/tools
	exeinto /usr/lib/${PN}/tools
	doexe *.pl *.py *.rc *.conf *.sh
	doexe tb2sylpheed update-po uudec

	if use kde; then
		local kdeprefix="$(kde-config --prefix)"
		local servicescript="sylpheed-kdeservicemenu.pl"
		cd ${S}/tools/kdeservicemenu
		for f in sylpheed-attach-files.desktop sylpheed-compress-attach.desktop; do
			sed -e "s:SCRIPT_PATH:${kdeprefix}/bin/${servicescript}:g" template_$f > $f
			install -m 0644 $f ${D}/${kdeprefix}/share/apps/konqueror/servicemenus/$f
		done
		insinto ${kdeprefix}/bin
		doexe ${servicescript}
	fi

	# kill useless plugin files
	rm -f ${D}/usr/lib*/${PN}/plugins/*.{la,a}
}

pkg_postinst() {
	ewarn
	ewarn "You have to re-emerge or update all external plugins"
	ewarn
	epause 5
	ebeep 3
}
