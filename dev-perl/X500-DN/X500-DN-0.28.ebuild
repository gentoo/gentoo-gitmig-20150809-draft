# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/X500-DN/X500-DN-0.28.ebuild,v 1.11 2005/08/26 00:36:43 agriffis Exp $

inherit perl-module
DESCRIPTION="handle X.500 DNs (Distinguished Names), parse and format them"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJOOP/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~rjoop/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc s390 sparc x86"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"

DEPEND="dev-perl/Parse-RecDescent"
