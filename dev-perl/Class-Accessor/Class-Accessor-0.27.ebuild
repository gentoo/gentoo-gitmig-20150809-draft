# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Accessor/Class-Accessor-0.27.ebuild,v 1.7 2006/10/20 18:55:02 kloeri Exp $

inherit perl-module

DESCRIPTION="Automated accessor generation"
HOMEPAGE="http://search.cpan.org/~kasei/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KA/KASEI/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc ~x86"
IUSE=""
SRC_TEST="do"
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
