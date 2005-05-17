# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Geo-IP/Geo-IP-1.23.ebuild,v 1.4 2005/05/17 15:48:51 mcummings Exp $

inherit perl-module

IUSE=""
DESCRIPTION="Look up country by IP Address"
# No longer available upstream
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${P}.readme"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~sparc ppc"
DEPEND="dev-libs/geoip"
