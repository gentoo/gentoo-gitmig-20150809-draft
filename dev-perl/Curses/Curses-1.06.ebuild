# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Per Wigren <wigren@home.se>
# /space/gentoo/cvsroot/gentoo-x86/dev-perl/XML-Simple/XML-Simple-1.05.ebuild,v 1.1 2001/08/21 15:39:29 hallski Exp

DESCRIPTION="Curses interface modules for Perl"
HOMEPAGE="http://cpan.valueclick.com/authors/id/W/WP/WPS/${P}.readme"

LICENSE="Artistic"

SRC_URI="http://cpan.valueclick.com/authors/id/W/WP/WPS/${P}.tar.gz"

DEPEND=">=sys-devel/perl-5
	>=sys-libs/ncurses-5"

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

mymake="/usr"
