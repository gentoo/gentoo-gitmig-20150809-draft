# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses/Curses-1.07.ebuild,v 1.2 2005/01/04 12:54:02 mcummings Exp $

inherit perl-module

DESCRIPTION="Curses interface modules for Perl"
HOMEPAGE="http://search.cpan.org/~giraffed/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GI/GIRAFFED/${P}.tgz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~s390"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=sys-libs/ncurses-5"

myconf="${myconf} GEN PANELS MENUS"

#This patch may or may not be backwards compatible with perl-5.6.1
#Add gaurd as necessary...
src_unpack() {
	unpack ${A}
	patch -p0 <${FILESDIR}/Curses-1.07-p5.8-fixes.diff || die
	cd ${S}
	einfo "Copying hints/c-linux.ncurses.h to c-config.h"
	cp ${S}/hints/c-linux.ncurses.h ${S}/c-config.h
}
