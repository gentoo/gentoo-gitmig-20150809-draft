# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses/Curses-1.06-r1.ebuild,v 1.1 2002/09/09 21:53:26 mcummings Exp $

inherit perl-module

DESCRIPTION="Curses interface modules for Perl"
HOMEPAGE="http://cpan.valueclick.com/authors/id/W/WP/WPS/${P}.readme"
SRC_URI="http://cpan.valueclick.com/authors/id/W/WP/WPS/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="${DEPEND}
	>=sys-libs/ncurses-5"

mymake="/usr"
myconf="${myconf} PANELS MENUS GEN"

#This patch may or may not be backwards compatible with perl-5.6.1
#Add gaurd as necessary...
src_unpack() {
        unpack ${A}
        patch -p0 <${FILESDIR}/Curses-1.06-p5.8-fixes.diff || die
}
