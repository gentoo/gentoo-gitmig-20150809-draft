# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Geo-IP/Geo-IP-1.23.ebuild,v 1.6 2006/07/04 08:59:16 ian Exp $

inherit perl-module

IUSE=""
DESCRIPTION="Look up country by IP Address"
# No longer available upstream
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${P}.readme"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="ppc ~sparc x86"
DEPEND="dev-libs/geoip"
RDEPEND="${DEPEND}"
