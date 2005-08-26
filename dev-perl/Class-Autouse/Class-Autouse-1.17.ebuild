# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Autouse/Class-Autouse-1.17.ebuild,v 1.5 2005/08/26 02:59:06 agriffis Exp $

inherit perl-module
DESCRIPTION="Runtime aspect loading of one or more classes"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk/${P}"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ppc sparc x86"
DEPEND="perl-core/Test-Simple
		dev-perl/ExtUtils-AutoInstall
		dev-perl/Scalar-List-Utils"

SRC_TEST="do"
