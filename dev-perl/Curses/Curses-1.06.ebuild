# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Per Wigren <wigren@home.se>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses/Curses-1.06.ebuild,v 1.3 2002/05/21 18:14:07 danarmak Exp $

DESCRIPTION="Curses interface modules for Perl"
HOMEPAGE="http://cpan.valueclick.com/authors/id/W/WP/WPS/${P}.readme"

LICENSE="Artistic"

SRC_URI="http://cpan.valueclick.com/authors/id/W/WP/WPS/${P}.tar.gz"

DEPEND=">=sys-devel/perl-5
	>=sys-libs/ncurses-5"


inherit perl-module

mymake="/usr"
