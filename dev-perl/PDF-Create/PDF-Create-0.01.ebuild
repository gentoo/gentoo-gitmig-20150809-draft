# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-Create/PDF-Create-0.01.ebuild,v 1.12 2006/08/05 19:43:41 mcummings Exp $

inherit perl-module

DESCRIPTION="PDF::Create allows you to create PDF documents"
SRC_URI="mirror://cpan/authors/id/F/FT/FTASSIN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ftassin/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
