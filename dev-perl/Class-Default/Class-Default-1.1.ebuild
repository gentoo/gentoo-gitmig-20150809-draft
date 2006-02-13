# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Default/Class-Default-1.1.ebuild,v 1.6 2006/02/13 10:55:56 mcummings Exp $

inherit perl-module

DESCRIPTION="Static calls apply to a default instantiation"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 ~ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Class-Inspector
		virtual/perl-Test-Simple
		dev-perl/ExtUtils-AutoInstall
		dev-perl/module-build"
