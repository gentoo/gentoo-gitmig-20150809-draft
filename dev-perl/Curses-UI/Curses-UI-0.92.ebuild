# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses-UI/Curses-UI-0.92.ebuild,v 1.1 2004/05/01 04:20:40 esammer Exp $

inherit perl-module

DESCRIPTION="Perl UI framework based on the curses library."
HOMEPAGE="http://search.cpan.org/~marcus/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/MA/MARCUS/${P}.tar.gz"
LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-perl/Curses
	dev-perl/Test-Pod
	dev-perl/TermReadKey"
