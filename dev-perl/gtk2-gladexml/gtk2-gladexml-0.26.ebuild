# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/dev-perl

inherit perl-module

MY_P=Gtk2-GladeXML-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl wrappers for the Gtk2::GladeXML utilities."
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2*
	>=gnome-base/libglade-2*
	=dev-perl/glib-${PV}
	=dev-perl/gtk2-perl-${PV}"
