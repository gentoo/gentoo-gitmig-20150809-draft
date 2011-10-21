# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/grisbi/grisbi-0.8.8.ebuild,v 1.6 2011/10/21 13:40:10 phajdan.jr Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

IUSE="nls ofx ssl"

DESCRIPTION="Grisbi is a personal accounting application for Linux"
HOMEPAGE="http://www.grisbi.org"
SRC_URI="mirror://sourceforge/grisbi/grisbi%20stable/0.8.x/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

RDEPEND="dev-libs/libxml2
	>=dev-libs/glib-2.18.0
	>=x11-libs/gtk+-2.12.0:2
	ssl? ( >=dev-libs/openssl-0.9.5 )
	ofx? ( >=dev-libs/libofx-0.7.0 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20"

pkg_setup() {
	G2CONF="
		--with-plugins
		--with-libxml2
		--without-cunit
		--disable-static
		$(use_with ssl openssl)
		$(use_with ofx)
		$(use_enable nls)"
	DOCS="AUTHORS NEWS README"
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "The first thing you should do is set up the browser command in"
	elog "preferences after you start up grisbi.  Otherwise you will not"
	elog "be able to see the help and manuals."
}
