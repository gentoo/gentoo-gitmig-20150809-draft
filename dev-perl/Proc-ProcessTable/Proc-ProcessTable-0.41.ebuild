# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-ProcessTable/Proc-ProcessTable-0.41.ebuild,v 1.3 2006/10/21 01:24:35 mcummings Exp $

inherit perl-module

DESCRIPTION="Unix process table information"
HOMEPAGE="http://search.cpan.org/~durist/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DU/DURIST/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
