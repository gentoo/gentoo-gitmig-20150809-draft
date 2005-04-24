# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Local/Time-Local-1.10.ebuild,v 1.11 2005/04/24 09:29:09 vapier Exp $

inherit perl-module

DESCRIPTION="Implements timelocal() and timegm()"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.readme"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE=""

SRC_TEST="do"
