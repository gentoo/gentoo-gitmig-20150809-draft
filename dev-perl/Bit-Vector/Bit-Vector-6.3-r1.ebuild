# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bit-Vector/Bit-Vector-6.3-r1.ebuild,v 1.2 2002/12/04 18:36:27 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/authors/id/S/ST/STBEY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/STBEY/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc alpha sparc sparc64"

DEPEND="${DEPEND}"

