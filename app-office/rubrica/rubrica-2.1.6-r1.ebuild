# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/rubrica/rubrica-2.1.6-r1.ebuild,v 1.2 2008/11/19 09:34:21 opfer Exp $

EAPI=1

inherit gnome2 eutils

MY_PN=${PN}2

DESCRIPTION="A contact database for Gnome"
HOMEPAGE="http://rubrica.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${MY_PN}-${PV}.tar.bz2"

IUSE="linguas_hu"
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-3"

DOCS="AUTHORS ChangeLog CREDITS INSTALL NEWS README TODO"
S=${WORKDIR}/${MY_PN}-${PV}/

RDEPEND="dev-libs/libxml2
	gnome-base/libglade
	gnome-base/gconf:2
	dev-perl/XML-Parser
	x11-libs/libnotify
	linguas_hu?	( >=sys-devel/gettext-0.16.1 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	gnome2_src_unpack
	cd "${S}"

	# False menu in locales
	epatch "${FILESDIR}/${P}_fix-menu-language.patch"
	# Missing gnome icons
	epatch "${FILESDIR}/${P}_missing-icons.patch"
	cd "${S}/po"
	epatch "${FILESDIR}/${P}_url-crash.patch"
}

src_compile() {
	gnome2_src_compile

	# Add Hungarian translation
	if use linguas_hu; then
		msgfmt "${FILESDIR}/hu.po" --output-file "po/hu.gmo" || die
	fi
}

src_install() {
	gnome2_src_install

	domenu "${FILESDIR}/${MY_PN}.desktop"
	if use linguas_hu; then
		domo po/hu.gmo || die
		dosym "${PN}.mo" "/usr/share/locale/hu/LC_MESSAGES/${MY_PN}.mo"
	fi
}
