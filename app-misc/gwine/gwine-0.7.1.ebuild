# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gwine/gwine-0.7.1.ebuild,v 1.2 2004/03/06 12:11:29 mcummings Exp $

inherit perl-module

DESCRIPTION="Gnome application to manage your wine cellar"
HOMEPAGE="http://gwine.tuxfamily.org"
SRC_URI="http://download.gna.org/gwine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

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
