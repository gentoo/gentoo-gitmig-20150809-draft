# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses/Curses-1.06.ebuild,v 1.14 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

DESCRIPTION="Curses interface modules for Perl"
HOMEPAGE="http://cpan.valueclick.com/authors/id/W/WP/WPS/${P}.readme"
SRC_URI="http://cpan.valueclick.com/authors/id/W/WP/WPS/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	>=sys-libs/ncurses-5"

mymake="/usr"
