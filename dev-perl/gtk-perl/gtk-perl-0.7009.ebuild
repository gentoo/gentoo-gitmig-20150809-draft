# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7009.ebuild,v 1.10 2005/07/14 23:23:17 agriffis Exp $

inherit perl-module eutils

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mlehmann/${MY_P}/"
IUSE="gnome gtkhtml opengl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="${DEPEND}
	media-libs/gdk-pixbuf
	=x11-libs/gtk+-1.2*
	dev-perl/XML-Writer
	dev-perl/XML-Parser
	opengl? ( =x11-libs/gtkglarea-1.2* )
	gnome? ( gnome-base/gnome-libs
			gnome-base/gnome-print
			=gnome-base/gnome-applets-1.4.0.5 )
	gtkhtml? ( gnome-extra/gtkhtml )"

mydoc="VERSIONS WARNING NOTES"

use gnome || myconf="${myconf} --without-gnome --without-gnomeprint --without-applets"
use opengl || myconf="${myconf} --without-gtkglarea"

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/gendef.patch
	perl -pi -e '/CCMD/ && s|/m;|/mg;|' */Makefile.PL
}

src_compile() {

	# the makemakersixeleven syntax doesn't seem to work
	perl Makefile.PL ${myconf} \
	PREFIX=${D}/usr INSTALLDIRS=vendor
}
