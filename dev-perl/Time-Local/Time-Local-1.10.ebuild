# Copyright 2000-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Local/Time-Local-1.10.ebuild,v 1.1 2004/06/10 19:51:29 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Implements timelocal() and timegm()"
SRC_URI="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~mips ~ppc ~sparc ~ia64"

SRC_TEST="do"
