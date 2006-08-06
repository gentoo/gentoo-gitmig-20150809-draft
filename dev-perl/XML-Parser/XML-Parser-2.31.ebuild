# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Parser/XML-Parser-2.31.ebuild,v 1.19 2006/08/06 01:40:39 mcummings Exp $

inherit perl-module

DESCRIPTION="A  Perl extension interface to James Clark's XML parser, expat."
SRC_URI="mirror://cpan/authors/id/C/CO/COOPERCL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~coopercl/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND=">=dev-libs/expat-1.95.1-r1
	dev-lang/perl"
RDEPEND="${DEPEND}"

