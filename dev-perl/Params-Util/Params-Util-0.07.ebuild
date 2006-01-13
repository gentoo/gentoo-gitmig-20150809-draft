# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Util/Params-Util-0.07.ebuild,v 1.7 2006/01/13 18:00:58 mcummings Exp $

inherit perl-module

DESCRIPTION="Utility funcions to aid in parameter checking"
HOMEPAGE="http://search.cpan.org/search?module=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=perl-core/Scalar-List-Utils-1.11"
