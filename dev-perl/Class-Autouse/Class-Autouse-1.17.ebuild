# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Autouse/Class-Autouse-1.17.ebuild,v 1.3 2005/08/15 09:58:52 mcummings Exp $

inherit perl-module
DESCRIPTION="Runtime aspect loading of one or more classes"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk/${P}"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~alpha ~ppc sparc"
DEPEND="perl-core/Test-Simple
		dev-perl/ExtUtils-AutoInstall
		dev-perl/Scalar-List-Utils"

SRC_TEST="do"
