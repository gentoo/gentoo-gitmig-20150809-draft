# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-String/Unicode-String-2.06-r1.ebuild,v 1.20 2006/07/05 12:54:43 ian Exp $

inherit perl-module

DESCRIPTION="A Unicode Perl Module"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND=">=virtual/perl-MIME-Base64-2.11"
RDEPEND="${DEPEND}"