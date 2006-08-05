# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-FromText/HTML-FromText-1.005.ebuild,v 1.11 2006/08/05 04:21:03 mcummings Exp $

inherit perl-module

DESCRIPTION="Mark up text as HTML"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/G/GD/GDR/${P}.readme"
SRC_URI="mirror://cpan/authors/id/G/GD/GDR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha ~hppa amd64 ia64"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
