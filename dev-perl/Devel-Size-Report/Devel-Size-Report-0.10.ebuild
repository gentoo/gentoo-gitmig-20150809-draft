# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Size-Report/Devel-Size-Report-0.10.ebuild,v 1.1 2006/01/11 10:39:31 mcummings Exp $

inherit perl-module

DESCRIPTION="Generate a size report for all elements in a structure for perl"
HOMEPAGE="http://search.cpan.org/~tels/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TE/TELS/devel/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Devel-Size-0.59
	>=perl-core/Test-Simple-0.47
	>=perl-core/Scalar-List-Utils-1.13
	>=perl-core/Time-HiRes-1.52
	>=dev-perl/Array-RefElem-1.00"
