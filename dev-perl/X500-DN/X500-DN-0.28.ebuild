# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/X500-DN/X500-DN-0.28.ebuild,v 1.5 2005/03/30 13:57:54 mcummings Exp $

inherit perl-module
DESCRIPTION="handle X.500 DNs (Distinguished Names), parse and format them"
SRC_URI="http://www.cpan.org/authors/id/R/RJ/RJOOP/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~rjoop/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"

DEPEND="dev-perl/Parse-RecDescent"
