# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7008-r11.ebuild,v 1.9 2005/08/26 01:02:58 agriffis Exp $

inherit perl-module eutils

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/${MY_P}.tar.gz"
HOMEPAGE="http://www.perl.org/"
IUSE="gnome opengl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ~ia64 ppc sparc x86"

DEPEND="${DEPEND}
	media-libs/gdk-pixbuf
	=x11-libs/gtk+-1.2*
	dev-perl/XML-Writer
	dev-perl/XML-Parser
	opengl? ( =x11-libs/gtkglarea-1.2* )
	gnome? ( gnome-base/gnome-libs )"

mydoc="VERSIONS WARNING NOTES"

use gnome || myconf="${myconf} --without-gnome --without-gnomeprint --without-applets"
use opengl || myconf="${myconf} --without-gtkglarea"

src_unpack() {

	unpack ${A}
	cd ${S}

	# Fix gdk-pixbuf-0.20.0 not detected, bug #10232.
	epatch ${FILESDIR}/${P}-gdkpixbuf-detect-fix.patch

	cp Makefile.PL Makefile.PL.bak
	perl -pi -e '/CCMD/ && s|/m;|/mg;|' */Makefile.PL
}

src_compile() {
	# the makemakersixeleven syntax doesn't seem to work
	perl Makefile.PL ${myconf} \
	PREFIX=${D}/usr INSTALLDIRS=vendor
}
