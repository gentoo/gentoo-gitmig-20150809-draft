# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Regexp::Shellish - Shell-like regular expressions"
SRC_URI="http://www.cpan.org/modules/by-authors/id/R/RB/RBS/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
SRC_TEST="do"
KEYWORDS="~alpha ~mips ~ppc ~sparc x86"
