# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sort-Versions/Sort-Versions-1.5.ebuild,v 1.1 2004/06/06 22:46:13 mcummings Exp $

inherit perl-module

DESCRIPTION="A perl 5 module for sorting of revision-like numbers"
HOMEPAGE="http://search.cpan.org/author/EDAVIS/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/E/ED/EDAVIS/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~mips ~s390"

SRC_TEST="do"
