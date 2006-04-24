# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Inspector/Class-Inspector-1.14.ebuild,v 1.1 2006/04/24 01:41:10 mcummings Exp $

inherit perl-module

DESCRIPTION="Provides information about Classes"
HOMEPAGE="http://search.cpan.org/~adamk/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/perl-Test-Simple"

SRC_TEST="do"
