# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Default/Class-Default-1.1.ebuild,v 1.1 2004/10/17 02:03:42 mcummings Exp $

inherit perl-module

DESCRIPTION="Static calls apply to a default instantiation"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc ~sparc"
IUSE=""
SRC_TEST="do"
style="builder"

DEPEND="dev-perl/Class-Inspector
		dev-perl/Test-Simple
		dev-perl/ExtUtils-AutoInstall
		dev-perl/module-build"
