# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7009.ebuild,v 1.1 2004/02/25 18:34:42 mcummings Exp $

inherit perl-module eutils

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/${MY_P}.tar.gz"
HOMEPAGE="http://www.perl.org/"
IUSE="gnome"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="${DEPEND}
	media-libs/gdk-pixbuf
	=x11-libs/gtk+-1.2*
	dev-perl/XML-Writer
	dev-perl/XML-Parser
	gnome? ( gnome-base/gnome-libs )"

mydoc="VERSIONS WARNING NOTES"

use gnome || myconf="${myconf} --without-gnome --without-gnomeprint --without-applets"

src_unpack() {

	unpack ${A}
	cd ${S}

	perl -pi -e '/CCMD/ && s|/m;|/mg;|' */Makefile.PL
}

src_compile() {
	# the makemakersixeleven syntax doesn't seem to work
	perl Makefile.PL ${myconf} \
	PREFIX=${D}/usr INSTALLDIRS=vendor
}
