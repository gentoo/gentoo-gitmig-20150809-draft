# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Local/Time-Local-1.05.ebuild,v 1.1 2003/06/08 02:54:03 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Implements timelocal() and timegm()"
SRC_URI="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DR/DROLSKY/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~arm ~hppa ~mips ~ppc ~sparc"

