# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MD5/MD5-2.02.ebuild,v 1.4 2002/07/31 13:24:45 cselkirk Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl MD5 Module"
SRC_URI="http://www.cpan.org/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/is/G/GA/GAAS/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc"

export OPTIMIZE="${CFLAGS}"
