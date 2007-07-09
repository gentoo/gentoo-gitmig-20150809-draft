# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-print/gnome2-print-1.000.ebuild,v 1.5 2007/07/09 11:38:27 mcummings Exp $

inherit perl-module

MY_P=Gnome2-Print-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome print libraries."
SRC_URI="mirror://cpan/authors/id/E/EB/EBASSI/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ebassi/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~ppc sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	dev-perl/glib-perl
	>=gnome-base/libgnome-2
	dev-perl/gnome2-perl
	>=gnome-base/libgnomeprint-2
	gnome-base/libgnomeprintui
	>=dev-perl/gtk2-perl-${PV}
	dev-lang/perl"
