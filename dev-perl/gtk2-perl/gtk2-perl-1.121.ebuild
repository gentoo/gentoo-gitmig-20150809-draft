# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-perl/gtk2-perl-1.121.ebuild,v 1.1 2006/04/26 01:00:56 mcummings Exp $

inherit perl-module

MY_P=Gtk2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK2"
HOMEPAGE="http://search.cpan.org/~tsch/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=dev-perl/glib-perl-1.120
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07"
