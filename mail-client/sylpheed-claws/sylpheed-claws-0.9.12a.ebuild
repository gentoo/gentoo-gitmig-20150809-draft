# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws/sylpheed-claws-0.9.12a.ebuild,v 1.6 2004/10/19 10:23:50 absinthe Exp $

IUSE="nls gnome dillo crypt spell imlib ssl ldap ipv6 pda clamav pdflib maildir mbox"

inherit eutils

# setting up plugin related variables
GS_PN=ghostscript-viewer
GS_PV=0.7

MAILDIR_PN=maildir
MAILDIR_PV=0.6

MBOX_PN=mailmbox
MBOX_PV=0.9

MY_GS=${GS_PN}-${GS_PV}
MY_MAILDIR=${MAILDIR_PN}-${MAILDIR_PV}
MY_MBOX=${MBOX_PN}-${MBOX_PV}

DESCRIPTION="Bleeding edge version of Sylpheed"
HOMEPAGE="http://sylpheed-claws.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	pdflib? ( mirror://sourceforge/${PN}/${MY_GS}.tar.bz2 )
	maildir? ( mirror://sourceforge/${PN}/${MY_MAILDIR}.tar.bz2 )
	mbox? ( http://${PN}.sourceforge.net/downloads/${MY_MBOX}.tar.gz )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc alpha amd64"

COMMONDEPEND="=x11-libs/gtk+-1.2*
	pda? ( >=app-pda/jpilot-0.99 )
	ssl? ( >=dev-libs/openssl-0.9.7 )
	ldap? ( >=net-nds/openldap-2.0.7 )
	crypt? ( =app-crypt/gpgme-0.3.14-r1 )
	dillo? ( www-client/dillo )
	gnome? ( >=media-libs/gdk-pixbuf-0.16 )
	imlib? ( >=media-libs/imlib-1.9.10 )
	spell? ( virtual/aspell-dict )
	pdflib? ( virtual/ghostscript )
	nls? ( >=sys-devel/gettext-0.12 )
	maildir? ( >=sys-libs/db-4.1 )"

DEPEND="${COMMONDEPEND}
	>=media-libs/compface-1.4
	>=sys-apps/sed-4"

RDEPEND="${COMMONDEPEND}
	app-misc/mime-types
	net-mail/metamail
	x11-misc/shared-mime-info"

PROVIDE="virtual/sylpheed"

src_unpack() {
	unpack ${A}

	for plugin in ${MY_GS} ${MY_MAILDIR} ${MY_MBOX}; do
		mv ${WORKDIR}/${plugin} ${S}/src/plugins
	done

	# use shared-mime-info
	cd ${S}/src
	epatch ${FILESDIR}/procmime.patch
}

plugin_compile() {
	if [ -z "${2}" ] || use ${2}; then
		cd ${S}/src/plugins/${1}
		einfo "Compiling plugin: ${1}"
		PKG_CONFIG_PATH=${S} \
		CFLAGS="-I${S} -I${S}/src -I${S}/src/common -I${S}/src/gtk ${CFLAGS}" \
		CXXFLAGS="${CFLAGS}" \
			econf --with-sylpheed-dir=../.. || die "plugin configure failed: ${1}"

		emake || die "plugin compile failed: ${1}"
	fi
}

plugin_install() {
	if [ -z "${2}" ] || use ${2}; then
		cd ${S}/src/plugins/${1}
		make DESTDIR="${D}" plugindir="/usr/lib/${PN}/plugins" install || die "plugin install failed: ${1}"
		docinto ${1}
		dodoc AUTHORS ChangeLog INSTALL NEWS README
	fi
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

	export GPGME_CONFIG=${ROOT}/usr/bin/gpgme3-config
	econf \
		--program-suffix=-claws \
		--enable-spamassassin-plugin \
		--enable-compface \
		${myconf} || die "./configure failed"

	emake || die

	# build the extra tools
	cd ${S}/tools
	emake || die

	# build external plugins
	plugin_compile ${MY_GS} pdflib
	plugin_compile ${MY_MAILDIR} maildir
	plugin_compile ${MY_MBOX} mbox

	cd ${S}
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

	# install external plugins
	plugin_install ${MY_GS} pdflib
	plugin_install ${MY_MAILDIR} maildir
	plugin_install ${MY_MBOX} mbox
}

pkg_postinst() {
	einfo "NOTE: Some plugins have to be re-loaded."
}
