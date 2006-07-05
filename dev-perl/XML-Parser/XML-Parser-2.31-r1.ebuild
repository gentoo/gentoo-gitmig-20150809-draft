# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Parser/XML-Parser-2.31-r1.ebuild,v 1.12 2006/07/05 13:33:10 ian Exp $

inherit perl-module

DESCRIPTION="A  Perl extension interface to James Clark's XML parser, expat."
SRC_URI="mirror://cpan/authors/id/C/CO/COOPERCL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~coopercl/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha hppa mips"
IUSE=""

DEPEND=">=dev-libs/expat-1.95.1-r1"
RDEPEND="${DEPEND}"