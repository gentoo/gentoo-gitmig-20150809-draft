# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-UPS/Business-UPS-2.0.ebuild,v 1.7 2006/08/04 22:40:09 mcummings Exp $

inherit perl-module

DESCRIPTION="A UPS Interface Module"
SRC_URI="mirror://cpan/authors/id/J/JW/JWHEELER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~jwheeler/${P}/"
IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ia64 sparc x86"

SRC_TEST="do"
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
