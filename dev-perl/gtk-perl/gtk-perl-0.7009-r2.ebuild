# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7009-r2.ebuild,v 1.3 2005/08/19 19:40:21 hansmi Exp $

inherit perl-module eutils

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mlehmann/${MY_P}/"
IUSE="gtkhtml gnome-print applet gnome opengl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="hppa ~ppc sparc x86"

DEPEND="${DEPEND}
	media-libs/gdk-pixbuf
	=x11-libs/gtk+-1.2*
	dev-perl/XML-Writer
	dev-perl/XML-Parser
	opengl? ( =x11-libs/gtkglarea-1.2* )
	gnome? ( gnome-base/gnome-libs
			gnome-print? ( gnome-base/gnome-print )
			applet? ( =gnome-base/gnome-applets-1.4.0.5 ) )
	gtkhtml? ( gnome-extra/gtkhtml )"

mydoc="VERSIONS WARNING NOTES"

use gnome || myconf="${myconf} --without-gnome"
use gnome-print || myconf="${myconf} --without-gnomeprint"
use applet || myconf="${myconf} --without-applets"
use opengl || myconf="${myconf} --without-gtkglarea"

src_unpack() {

	unpack ${A}
	cd ${S}
	use gnome || einfo "${PN} being built without gnome support"
	use gnome-print || einfo "${PN} being built without gnome-print support"
	use applet || einfo "${PN} being built without gnome-applets-1.4 support"

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
