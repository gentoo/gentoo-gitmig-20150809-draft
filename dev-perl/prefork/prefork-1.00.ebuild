# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/prefork/prefork-1.00.ebuild,v 1.6 2006/01/03 21:22:30 plasmaroo Exp $

inherit perl-module

DESCRIPTION="Optimized module loading for forking or non-forking processes"
HOMEPAGE="http://search.cpan.org/search?module=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=perl-core/File-Spec-0.80
		>=perl-core/Scalar-List-Utils-1.10"
