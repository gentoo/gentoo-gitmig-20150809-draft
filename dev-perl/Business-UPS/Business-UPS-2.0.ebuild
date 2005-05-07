# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-UPS/Business-UPS-2.0.ebuild,v 1.2 2005/05/07 03:07:05 gustavoz Exp $

inherit perl-module

DESCRIPTION="A UPS Interface Module"
SRC_URI="mirror://cpan/authors/id/J/JW/JWHEELER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~jwheeler/${P}/"
IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~sparc"

SRC_TEST="do"
