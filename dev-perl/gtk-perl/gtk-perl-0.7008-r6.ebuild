# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk-perl/gtk-perl-0.7008-r6.ebuild,v 1.6 2003/02/13 11:26:13 vapier Exp $

inherit perl-module

MY_P=Gtk-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK"
SRC_URI="http://www.gtkperl.org/${MY_P}.tar.gz"
HOMEPAGE="http://www.perl.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	media-libs/gdk-pixbuf
	=x11-libs/gtk+-1.2*
	dev-perl/XML-Writer
	dev-perl/XML-Parser
	gnome? ( gnome-base/gnome-libs )"

mydoc="VERSIONS WARNING NOTES"

use gnome || (myconf="${myconf} --without-module gnome --without-module gnomeprint")
src_compile() {

    cd ${S}
	cp Makefile.PL Makefile.PL.bak
	perl -pi -e '/CCMD/ && s|/m;|/mg;|' */Makefile.PL
	perl-module_src_compile

}
