# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Catalog/XML-Catalog-0.02-r2.ebuild,v 1.9 2005/08/26 00:37:20 agriffis Exp $

inherit perl-module

DESCRIPTION="Perl Module"
SRC_URI="mirror://cpan/authors/id/E/EB/EBOHLMAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ebohlman/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29
	>=dev-perl/libwww-perl-5.48"
