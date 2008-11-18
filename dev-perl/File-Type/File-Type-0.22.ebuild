# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Type/File-Type-0.22.ebuild,v 1.15 2008/11/18 14:59:22 tove Exp $

inherit perl-module

DESCRIPTION="determine file type using magic "
SRC_URI="mirror://cpan/authors/id/P/PM/PMISON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pmison/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 hppa ia64 ~ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=virtual/perl-Module-Build-0.28
	dev-lang/perl"
