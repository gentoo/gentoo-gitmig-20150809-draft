# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Annotate/Algorithm-Annotate-0.10.ebuild,v 1.12 2006/07/03 20:01:14 ian Exp $

inherit perl-module

HOMEPAGE="http://search.cpan.org/~clkao/${P}/"
DESCRIPTION="Algorithm::Annotate - represent a series of changes in annotate form"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ia64 ~ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/Algorithm-Diff-1.15"
RDEPEND="${DEPEND}"