# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Local/Time-Local-1.07.ebuild,v 1.2 2004/01/08 19:18:22 gustavoz Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Implements timelocal() and timegm()"
SRC_URI="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~amd64 ~alpha ~arm hppa ~mips ~ppc sparc"

