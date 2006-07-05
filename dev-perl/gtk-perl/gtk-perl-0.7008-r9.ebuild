# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7008-r9.ebuild,v 1.14 2006/07/05 17:28:32 ian Exp $

inherit perl-module eutils

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/${MY_P}.tar.gz"
HOMEPAGE="http://www.perl.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE="gnome"

DEPEND="media-libs/gdk-pixbuf
	=x11-libs/gtk+-1.2*
	dev-perl/XML-Writer
	dev-perl/XML-Parser
	gnome? ( gnome-base/gnome-libs )"
RDEPEND="${DEPEND}"

mydoc="VERSIONS WARNING NOTES"

use gnome || myconf="${myconf} --without-gnome --without-gnomeprint --without-applets"

src_unpack() {

	unpack ${A}
	cd ${S}

	# Fix gdk-pixbuf-0.20.0 not detected, bug #10232.
	epatch ${FILESDIR}/${P}-gdkpixbuf-detect-fix.patch

	cp Makefile.PL Makefile.PL.bak
	perl -pi -e '/CCMD/ && s|/m;|/mg;|' */Makefile.PL

	perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr
}


src_compile() {

	make ${mymake} || die "compilation failed"
}