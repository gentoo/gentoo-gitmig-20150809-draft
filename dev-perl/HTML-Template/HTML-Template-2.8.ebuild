# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Template/HTML-Template-2.8.ebuild,v 1.9 2006/10/20 19:46:34 kloeri Exp $

inherit perl-module

DESCRIPTION="A Perl module to use HTML Templates"
HOMEPAGE="http://cpan.org/modules/by-module/HTML/${P}.readme"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-1 GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
