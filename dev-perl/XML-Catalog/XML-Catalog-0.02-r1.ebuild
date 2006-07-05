# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Catalog/XML-Catalog-0.02-r1.ebuild,v 1.17 2006/07/05 13:15:10 ian Exp $

inherit perl-module

DESCRIPTION="Perl Module"
SRC_URI="mirror://cpan/authors/id/E/EB/EBOHLMAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ebohlman/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND=">=dev-perl/XML-Parser-2.29
	>=dev-perl/libwww-perl-5.48"
RDEPEND="${DEPEND}"