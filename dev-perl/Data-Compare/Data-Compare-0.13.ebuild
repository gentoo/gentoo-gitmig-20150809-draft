# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Compare/Data-Compare-0.13.ebuild,v 1.5 2006/07/04 07:33:57 ian Exp $

inherit perl-module

DESCRIPTION="compare perl data structures"
HOMEPAGE="http://search.cpan.org/~dcantrell/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DC/DCANTRELL/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/File-Find-Rule
		dev-perl/Scalar-Properties"
RDEPEND="${DEPEND}"