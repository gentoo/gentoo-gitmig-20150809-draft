# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Parser/XML-Parser-2.34.ebuild,v 1.12 2005/01/04 14:20:48 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl extension interface to James Clark's XML parser, expat"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE=""

DEPEND=">=dev-libs/expat-1.95.1-r1"
