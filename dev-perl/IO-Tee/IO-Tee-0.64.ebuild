# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tee/IO-Tee-0.64.ebuild,v 1.8 2006/08/17 21:19:10 mcummings Exp $

inherit perl-module

DESCRIPTION="Multiplex output to multiple output handles"
HOMEPAGE="http://search.cpan.org/~kenshan/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KE/KENSHAN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
