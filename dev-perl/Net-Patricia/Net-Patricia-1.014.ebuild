# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Patricia/Net-Patricia-1.014.ebuild,v 1.7 2006/10/21 00:43:06 mcummings Exp $

inherit perl-module

DESCRIPTION="Patricia Trie perl module for fast IP address lookups"
HOMEPAGE="http://search.cpan.org/~plonka/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PL/PLONKA/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc ~x86"
IUSE=""

#SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
