# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Template/HTML-Template-2.7.ebuild,v 1.12 2006/10/11 19:50:05 corsair Exp $

inherit perl-module

DESCRIPTION="A Perl module to use HTML Templates"
HOMEPAGE="http://cpan.org/modules/by-module/HTML/${P}.readme"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-1 GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
