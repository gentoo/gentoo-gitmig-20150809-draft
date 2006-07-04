# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CursesWidgets/CursesWidgets-1.997.ebuild,v 1.8 2006/07/04 07:11:06 ian Exp $

inherit perl-module

IUSE=""
#S=${WORKDIR}/${P}
DESCRIPTION="Curses::Widgets is designed to provide high level APIs for rapid user interface design on the console in Perl."
HOMEPAGE="http://www.digitalmages.com/perl/CursesWidgets/index.html"
SRC_URI="http://www.digitalmages.com/perl/CursesWidgets/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ia64 ppc s390 sparc x86"

DEPEND=">=sys-libs/ncurses-5
	>=dev-perl/Curses-1.06"
RDEPEND="${DEPEND}"