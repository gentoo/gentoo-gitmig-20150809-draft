# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-print/gnome2-print-0.94.ebuild,v 1.14 2011/03/29 10:25:32 angelos Exp $

EAPI=1
inherit perl-module

MY_P=Gnome2-Print-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome print libraries."
SRC_URI="mirror://cpan/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rmcfarla/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND="x11-libs/gtk+:2
	dev-perl/glib-perl
	>=gnome-base/libgnome-2
	dev-perl/gnome2-perl
	gnome-base/libgnomeprint:2.2
	>=dev-perl/gtk2-perl-${PV}
	dev-lang/perl"
RDEPEND="${DEPEND}"
