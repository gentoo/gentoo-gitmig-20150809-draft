# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-perl/gtk2-perl-1.040.ebuild,v 1.1 2004/03/29 14:32:26 mcummings Exp $

inherit perl-module

MY_P=Gtk2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK2"
HOMEPAGE="http://search.cpan.org/~rmcfarla/${MY_P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE="perl"

DEPEND=">=x11-libs/gtk+-2*
	>=dev-perl/glib-perl-${PV}
	>=dev-perl/extutils-depends-0.2*
	dev-perl/extutils-pkgconfig"
