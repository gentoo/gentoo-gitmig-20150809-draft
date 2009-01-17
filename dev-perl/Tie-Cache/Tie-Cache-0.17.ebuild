# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-Cache/Tie-Cache-0.17.ebuild,v 1.7 2009/01/17 22:15:39 robbat2 Exp $

inherit perl-module

DESCRIPTION="In memory size limited LRU cache"
HOMEPAGE="http://search.cpan.org/search?query=Tie-Cache&mode=dist"
SRC_URI="mirror://cpan/authors/id/C/CH/CHAMAS/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
