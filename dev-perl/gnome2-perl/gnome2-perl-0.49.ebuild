# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-perl/gnome2-perl-0.49.ebuild,v 1.5 2004/07/14 17:40:19 agriffis Exp $

inherit perl-module

MY_P=Gnome2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome libraries"
HOMEPAGE="http://gtk2-perl.sf.net/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2*
	>=gnome-base/libgnomeprint-2*
	>=dev-perl/gtk2-perl-${PV}
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	>=dev-perl/gtk2-perl-1*
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	dev-perl/glib-perl
	dev-perl/gnome2-vfs-perl"
