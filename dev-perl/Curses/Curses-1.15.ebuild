# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses/Curses-1.15.ebuild,v 1.1 2006/10/21 16:27:11 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="Curses interface modules for Perl"
HOMEPAGE="http://search.cpan.org/~giraffed/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GI/GIRAFFED/${P}.tgz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"

myconf="${myconf} GEN PANELS MENUS"

#This patch may or may not be backwards compatible with perl-5.6.1
#Add gaurd as necessary...
src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/Curses-1.08-p5.8-fixes.diff
	einfo "Copying hints/c-linux.ncurses.h to c-config.h"
	cp hints/c-linux.ncurses.h c-config.h
}
