# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-REQ/OpenCA-REQ-0.7.35.ebuild,v 1.3 2002/07/25 04:43:33 seemant Exp $

inherit perl-module
S=${WORKDIR}/${P}
DESCRIPTION="The perl OpenCA::REQ Module"
SRC_URI="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

export OPTIMIZE="${CFLAGS}"
