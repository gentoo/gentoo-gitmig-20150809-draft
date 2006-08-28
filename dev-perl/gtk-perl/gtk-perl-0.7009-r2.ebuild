# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7009-r2.ebuild,v 1.11 2006/08/28 00:30:56 mcummings Exp $

inherit perl-module eutils

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mlehmann/${MY_P}/"
IUSE="gtkhtml gnome-print gnome opengl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ppc sparc x86"

DEPEND="media-libs/gdk-pixbuf
	=x11-libs/gtk+-1.2*
	dev-perl/XML-Writer
	dev-perl/XML-Parser
	opengl? ( =x11-libs/gtkglarea-1.2* )
	gnome? ( gnome-base/gnome-libs
			gnome-print? ( gnome-base/gnome-print ) )
	gtkhtml? ( =gnome-extra/gtkhtml-1* )
	dev-lang/perl"
RDEPEND="${DEPEND}"

mydoc="VERSIONS WARNING NOTES"

myconf="${myconf} --without-applets"
use gnome || myconf="${myconf} --without-gnome"
use gnome-print || myconf="${myconf} --without-gnomeprint"
use opengl || myconf="${myconf} --without-gtkglarea"

src_unpack() {

	unpack ${A}
	cd ${S}
	use gnome || einfo "${PN} being built without gnome support"
	use gnome-print || einfo "${PN} being built without gnome-print support"

	epatch ${FILESDIR}/gendef.patch
	perl -pi -e '/CCMD/ && s|/m;|/mg;|' */Makefile.PL
	sed -i 's/MesaGL/GL/g' GtkGLArea/Makefile.PL
	sed -i 's/MesaGL/GL/g' GtkGLArea/pkg.pl
}

src_compile() {

	# the makemakersixeleven syntax doesn't seem to work
	perl Makefile.PL ${myconf} \
	PREFIX=${D}/usr INSTALLDIRS=vendor
}

