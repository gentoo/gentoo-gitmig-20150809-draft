# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MD5/MD5-2.02.ebuild,v 1.2 2002/07/25 04:13:26 seemant Exp $

# Inherit the perl-module.eclass functions

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl MD5 Module"
SRC_URI="http://www.cpan.org/authors/id/G/GA/GAAS/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/authors/is/G/GA/GAAS/${P}.readme"
SLOT="0"
export OPTIMIZE="${CFLAGS}"
