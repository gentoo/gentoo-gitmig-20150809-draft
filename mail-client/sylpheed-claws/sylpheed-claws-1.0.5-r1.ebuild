# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws/sylpheed-claws-1.0.5-r1.ebuild,v 1.9 2006/12/08 11:22:38 genone Exp $

IUSE="nls gnome dillo crypt spell imlib ssl ldap ipv6 pda clamav pdf maildir xface kde" # mbox

inherit eutils

# setting up plugin related variables
GS_VERSION="ghostscript-viewer-0.8"
PGP_VERSION="pgpinline-0.5"
MAILDIR_VERSION="maildir-0.7"

DESCRIPTION="Bleeding edge version of Sylpheed"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
#SRC_URI="mirror://gentoo/${P}.tar.bz2 http://dev.gentoo.org/~genone/distfiles/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

COMMONDEPEND="=x11-libs/gtk+-1.2*
	pda? ( >=app-pda/jpilot-0.99 )
	ssl? ( >=dev-libs/openssl-0.9.7 )
	ldap? ( >=net-nds/openldap-2.0.7 )
	crypt? ( =app-crypt/gpgme-0.3.14-r1 )
	dillo? ( www-client/dillo )
	clamav? ( app-antivirus/clamav )
	gnome? ( >=media-libs/gdk-pixbuf-0.16 )
	imlib? ( >=media-libs/imlib-1.9.10 )
	spell? ( virtual/aspell-dict )
	nls? ( >=sys-devel/gettext-0.12 )
	kde? ( kde-base/kdelibs )
	x11-libs/startup-notification"

DEPEND="${COMMONDEPEND}
	>=media-libs/compface-1.4
	>=sys-apps/sed-4"

RDEPEND="${COMMONDEPEND}
	app-misc/mime-types
	net-mail/metamail
	x11-misc/shared-mime-info
	!mail-client/claws-mail"

PDEPEND="pdf? ( =mail-client/${PN}-${GS_VERSION} )
		 maildir? ( =mail-client/${PN}-${MAILDIR_VERSION} )
		 crypt? ( =mail-client/${PN}-${PGP_VERSION} )"
#		 mbox? ( =mail-client/${PN}-${MBOX_VERSION} )"

PROVIDE="virtual/sylpheed"

src_unpack() {
	unpack ${A}

	# use shared-mime-info
	cd ${S}/src
	epatch ${FILESDIR}/procmime.patch
	epatch ${FILESDIR}/ldif-buffer-overflow-fix.diff
}

src_compile() {
	local myconf

	myconf="${myconf} `use_enable gnome gdk-pixbuf`"
	myconf="${myconf} `use_enable imlib`"
	myconf="${myconf} `use_enable spell aspell`"
	myconf="${myconf} `use_enable ldap`"
	myconf="${myconf} `use_enable ssl openssl`"
	myconf="${myconf} `use_enable crypt gpgme`"
	myconf="${myconf} `use_enable ipv6`"
	myconf="${myconf} `use_enable pda jpilot`"
	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_enable dillo dillo-viewer-plugin`"
	myconf="${myconf} `use_enable clamav clamav-plugin`"
	myconf="${myconf} `use_enable crypt pgpmime-plugin`"
	myconf="${myconf} `use_enable xface compface`"

	export GPGME_CONFIG=${ROOT}/usr/bin/gpgme3-config
	econf \
		--program-suffix=-claws \
		--enable-spamassassin-plugin \
		${myconf} || die "./configure failed"

	emake || die

	# build the extra tools
	cd ${S}/tools
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	local menuentry="/usr/share/applications/sylpheed-claws.desktop"
	insinto /usr/share/applications
	newins ${S}/sylpheed.desktop sylpheed-claws.desktop
	dosed "s/Sylpheed/Sylpheed Claws/" ${menuentry}
	dosed "s/sylpheed/sylpheed-claws/" ${menuentry}
	rm -rf ${D}/usr/share/gnome

	insinto /usr/share/pixmaps
	newins ${S}/sylpheed.png sylpheed-claws.png
	rm -f ${D}/usr/share/pixmaps/sylpheed.png

	dodoc AUTHORS ChangeLog* INSTALL* NEWS README* TODO*
	docinto tools
	dodoc tools/README*

	# install the extra tools
	cd ${S}/tools
	exeinto /usr/lib/${PN}/tools
	doexe *.pl *.py *.rc *.conf *.sh
	doexe tb2sylpheed update-po uudec gpg-sign-syl

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
}

pkg_postinst() {
	ewarn
	ewarn "You have to re-emerge or update all external plugins"
	ewarn
	epause 5
	ebeep 3
}
