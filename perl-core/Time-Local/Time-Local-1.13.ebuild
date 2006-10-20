# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Time-Local/Time-Local-1.13.ebuild,v 1.2 2006/10/20 21:04:56 mcummings Exp $

inherit perl-module

DESCRIPTION="Implements timelocal() and timegm()"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.readme"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
