# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gwine/gwine-0.10.1.ebuild,v 1.6 2007/03/06 07:14:24 opfer Exp $

inherit eutils gnome2 perl-app

DESCRIPTION="Gnome application to manage your wine cellar"
HOMEPAGE="http://home.gna.org/gwine/"
SRC_URI="http://download.gna.org/gwine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0
	>=dev-perl/glib-perl-0.90
	>=dev-perl/gtk2-perl-0.90
	>=dev-perl/gnome2-perl-1.021
	>=dev-perl/gtk2-gladexml-1.003
	dev-perl/gnome2-gconf
	dev-perl/libintl-perl
	dev-perl/DateTime"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-package.patch
}

pkg_postinst() {
	perl-module_pkg_postinst
	gnome2_gconf_install
}
