# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-String/Unicode-String-2.09.ebuild,v 1.16 2007/04/16 06:32:57 corsair Exp $

inherit perl-module

DESCRIPTION="String manipulation for Unicode strings"
HOMEPAGE="http://search.cpan.org/~gaas/"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=virtual/perl-MIME-Base64-2.11
	dev-lang/perl"
