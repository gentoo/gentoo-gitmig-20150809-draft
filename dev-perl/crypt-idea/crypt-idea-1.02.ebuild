# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-idea/crypt-idea-1.02.ebuild,v 1.1 2003/06/23 17:52:30 mcummings Exp $

inherit perl-module

MY_P=Crypt-IDEA-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Parse and save PGP packet streams"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DP/DPARIS/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/D/DP/DPARIS/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc"

