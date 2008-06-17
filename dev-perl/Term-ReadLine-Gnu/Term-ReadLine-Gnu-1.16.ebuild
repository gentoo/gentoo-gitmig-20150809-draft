# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadLine-Gnu/Term-ReadLine-Gnu-1.16.ebuild,v 1.6 2008/06/17 06:51:07 wormo Exp $

inherit versionator perl-module

DESCRIPTION="GNU Readline XS library wrapper"
HOMEPAGE="http:/search.cpan.org/~hayashi/"
SRC_URI="mirror://cpan/authors/id/H/HA/HAYASHI/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc x86"
IUSE=""
#SRC_TEST="do"

DEPEND="sys-libs/readline
		dev-lang/perl"
