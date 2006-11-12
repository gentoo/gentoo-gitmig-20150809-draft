# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-String/Unicode-String-2.09.ebuild,v 1.12 2006/11/12 03:47:10 vapier Exp $

inherit perl-module

DESCRIPTION="String manipulation for Unicode strings"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-MIME-Base64-2.11
	dev-lang/perl"
RDEPEND="${DEPEND}"
