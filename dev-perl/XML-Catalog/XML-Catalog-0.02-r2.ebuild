# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Catalog/XML-Catalog-0.02-r2.ebuild,v 1.15 2007/01/19 17:20:19 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl Module"
SRC_URI="mirror://cpan/authors/id/E/EB/EBOHLMAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ebohlman/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-perl/XML-Parser-2.29
	>=dev-perl/libwww-perl-5.48
	dev-lang/perl"
