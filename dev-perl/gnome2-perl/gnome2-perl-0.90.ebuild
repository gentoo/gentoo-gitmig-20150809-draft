# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-perl/gnome2-perl-0.90.ebuild,v 1.1 2004/03/29 14:45:05 mcummings Exp $

inherit perl-module

MY_P=Gnome2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome libraries"
HOMEPAGE="http://search.cpan.org/~rmcfarla/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND=">=x11-libs/gtk+-2*
	>=gnome-base/libgnomeprint-2*
	>=dev-perl/gtk2-perl-${PV}
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	>=dev-perl/gtk2-perl-1*
	>=dev-perl/extutils-depends-0.2*
	dev-perl/extutils-pkgconfig
	dev-perl/glib-perl
	dev-perl/gnome2-vfs-perl"
