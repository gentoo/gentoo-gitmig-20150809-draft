# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/X500-DN/X500-DN-0.28.ebuild,v 1.1 2004/06/06 13:24:01 mcummings Exp $

inherit perl-module
S=${WORKDIR}/${P}
DESCRIPTION="handle X.500 DNs (Distinguished Names), parse and format them"
SRC_URI="http://www.cpan.org/authors/id/R/RJ/RJOOP/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~rjoop/${P}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"
