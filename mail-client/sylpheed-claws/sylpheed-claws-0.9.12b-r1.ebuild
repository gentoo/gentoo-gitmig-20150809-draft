# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws/sylpheed-claws-0.9.12b-r1.ebuild,v 1.1 2004/10/17 23:06:51 genone Exp $

IUSE="nls gnome dillo crypt spell imlib ssl ldap ipv6 pda clamav pdflib maildir mbox calendar xface"

inherit eutils

# setting up plugin related variables
GS_VERSION="ghostscript-viewer-0.8"
PGP_VERSION="pgpinline-0.2"
MAILDIR_VERSION="maildir-0.6"
MBOX_VERSION="mailmbox-0.9"
VCAL_VERSION="vcalendar-0.4"

DESCRIPTION="Bleeding edge version of Sylpheed"
HOMEPAGE="http://sylpheed-claws.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

COMMONDEPEND="=x11-libs/gtk+-1.2*
	pda? ( >=app-pda/jpilot-0.99 )
	ssl? ( >=dev-libs/openssl-0.9.7 )
	ldap? ( >=net-nds/openldap-2.0.7 )
	crypt? ( =app-crypt/gpgme-0.3.14-r1 )
	dillo? ( www-client/dillo )
	gnome? ( >=media-libs/gdk-pixbuf-0.16 )
	imlib? ( >=media-libs/imlib-1.9.10 )
	spell? ( virtual/aspell-dict )
	nls? ( >=sys-devel/gettext-0.12 )"

DEPEND="${COMMONDEPEND}
	>=media-libs/compface-1.4
	>=sys-apps/sed-4"

RDEPEND="${COMMONDEPEND}
	app-misc/mime-types
	net-mail/metamail
	x11-misc/shared-mime-info"

PDEPEND="gs? ( =mail-client/${PN}-${GS_VERSION} )
		 maildir? ( =mail-client/${PN}-${MAILDIR_VERSION} )
		 mbox? ( =mail-client/${PN}-${MBOX_VERSION} )
		 crypt? ( =mail-client/${PN}-${PGP_VERSION} )
		 calendar? ( =mail-client/${PN}-${VCAL_VERSION} )"

PROVIDE="virtual/sylpheed"

src_unpack() {
	unpack ${A}

	# use shared-mime-info
	cd ${S}/src
	epatch ${FILESDIR}/procmime.patch
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

	local menuentry="/usr/share/gnome/apps/Internet/sylpheed.desktop"
	if use gnome; then
		dosed "s/Sylpheed/Sylpheed Claws/" ${menuentry}
		dosed "s/sylpheed/sylpheed-claws/" ${menuentry}
		mv ${D}${menuentry} ${D}${menuentry/sylpheed/sylpheed-claws}
	else
		rm -rf ${D}/usr/share/gnome
	fi

	dodir /usr/share/pixmaps
	mv ${D}/usr/share/pixmaps/sylpheed{,-claws}.png

	dodoc AUTHORS ChangeLog* INSTALL* NEWS README* TODO*
	docinto tools
	dodoc tools/README*

	# install the extra tools
	cd ${S}/tools
	exeinto /usr/lib/${PN}/tools
	doexe *.pl *.py *.rc *.conf *.sh gpg-sign-syl
	doexe tb2sylpheed update-po uudec
}

pkg_postinst() {
	einfo "NOTE: Some plugins have to be re-loaded."
}
