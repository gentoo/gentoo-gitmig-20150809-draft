# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-idea/crypt-idea-1.02.ebuild,v 1.3 2004/02/21 08:21:18 vapier Exp $

inherit perl-module

MY_P=Crypt-IDEA-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Parse and save PGP packet streams"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/D/DP/DPARIS/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DP/DPARIS/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ~amd64"
