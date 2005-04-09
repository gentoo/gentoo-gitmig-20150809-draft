# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-perl/gtk2-perl-1.062.ebuild,v 1.4 2005/04/09 07:54:20 corsair Exp $

inherit perl-module

MY_P=Gtk2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK2"
HOMEPAGE="http://search.cpan.org/~tsch/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa ~amd64 ppc64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2*
	>=dev-perl/glib-perl-1.062*
	>=dev-perl/extutils-depends-0.205*
	>=dev-perl/extutils-pkgconfig-1.07*"
