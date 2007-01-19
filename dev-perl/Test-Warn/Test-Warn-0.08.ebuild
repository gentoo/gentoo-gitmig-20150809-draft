# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Warn/Test-Warn-0.08.ebuild,v 1.10 2007/01/19 16:53:01 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension to test methods for warnings"
HOMEPAGE="http://search.cpan.org/~bigj/"
SRC_URI="mirror://cpan/authors/id/B/BI/BIGJ/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Test-Exception
	>=dev-perl/Sub-Uplevel-0.09-r1
	dev-perl/Array-Compare
	dev-perl/Tree-DAG_Node
	dev-lang/perl"
