# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-perl/gnome2-perl-0.49.ebuild,v 1.1 2003/12/30 15:53:17 mcummings Exp $

inherit perl-module

MY_P=Gnome2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome libraries."
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc ~alpha"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2*
	>=gnome-base/libgnomeprint-2*
	>=dev-perl/gtk2-perl-${PV}
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	>=dev-perl/gtk2-perl-1*
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	dev-perl/glib-perl
	dev-perl/gnome2-vfs-perl"
