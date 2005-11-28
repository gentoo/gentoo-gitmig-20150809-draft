# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gwine/gwine-0.7.1.ebuild,v 1.7 2005/11/28 12:10:12 mcummings Exp $

inherit perl-app

DESCRIPTION="Gnome application to manage your wine cellar"
HOMEPAGE="http://home.gna.org/gwine/"
SRC_URI="http://download.gna.org/gwine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0
	>=dev-perl/glib-perl-0.90
	>=dev-perl/gtk2-perl-0.90
	>=dev-perl/gnome2-perl-0.28
	dev-perl/DateTime"

src_compile() {
	cp Makefile.PL Makefile.PL.old
	sed -e 's#. "$path" .#. "/usr/share/pixmaps" .#' Makefile.PL.old >Makefile.PL
	 perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr INSTALLDIRS=vendor
}
