# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MD5/MD5-2.02-r1.ebuild,v 1.5 2003/05/31 21:10:04 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl MD5 Module"
SRC_URI="http://www.cpan.org/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/is/G/GA/GAAS/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="dev-perl/Digest-MD5"

export OPTIMIZE="${CFLAGS}"
