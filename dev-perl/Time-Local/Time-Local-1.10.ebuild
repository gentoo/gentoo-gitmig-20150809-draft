# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Local/Time-Local-1.10.ebuild,v 1.8 2005/04/07 14:32:09 nigoro Exp $

inherit perl-module

DESCRIPTION="Implements timelocal() and timegm()"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~alpha ~hppa ~mips ~ppc sparc ~ia64 ppc64"
IUSE=""

SRC_TEST="do"
