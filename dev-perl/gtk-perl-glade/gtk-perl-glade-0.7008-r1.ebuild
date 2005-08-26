# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl-glade/gtk-perl-glade-0.7008-r1.ebuild,v 1.6 2005/08/26 01:06:10 agriffis Exp $

inherit perl-module

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/${MY_P}.tar.gz"
HOMEPAGE="http://www.gtkperl.org/"
IUSE="gnome"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"

DEPEND="${DEPEND}
	media-libs/gdk-pixbuf
	=x11-libs/gtk+-1.2*
	dev-perl/XML-Writer
	dev-perl/XML-Parser
	gnome? ( gnome-base/gnome-libs )
	dev-util/glade"

mydoc="VERSIONS WARNING NOTES"

use gnome || myconf="${myconf} --without-gnome --without-gnomeprint --without-applets"

src_unpack() {
	unpack ${A}
	# Fix gdk-pixbuf-0.20.0 not detected, bug #10232.
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gdkpixbuf-detect-fix.patch || die
	perl -pi -e '/CCMD/ && s|/m;|/mg;|' */Makefile.PL
}

src_compile() {
	cd ${S}
	perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr INSTALLDIRS=vendor
}
