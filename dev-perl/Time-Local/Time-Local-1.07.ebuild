# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Local/Time-Local-1.07.ebuild,v 1.3 2004/02/09 22:25:55 darkspecter Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Implements timelocal() and timegm()"
SRC_URI="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~amd64 ~alpha ~arm hppa ~mips ppc sparc"

