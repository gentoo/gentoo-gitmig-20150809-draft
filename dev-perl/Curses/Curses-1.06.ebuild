# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses/Curses-1.06.ebuild,v 1.18 2005/01/04 12:54:02 mcummings Exp $

inherit perl-module

DESCRIPTION="Curses interface modules for Perl"
HOMEPAGE="http://search.cpan.org/~wps/${P}/"
SRC_URI="mirror://cpan/authors/id/W/WP/WPS/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=sys-libs/ncurses-5"

mymake="/usr"
