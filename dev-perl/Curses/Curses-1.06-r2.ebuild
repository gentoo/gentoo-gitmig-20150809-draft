# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses/Curses-1.06-r2.ebuild,v 1.10 2005/01/04 12:54:02 mcummings Exp $

inherit perl-module

DESCRIPTION="Curses interface modules for Perl"
HOMEPAGE="http://search.cpan.org/~wps/${P}/"
SRC_URI="mirror://cpan/authors/id/W/WP/WPS/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha s390"
IUSE=""

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
