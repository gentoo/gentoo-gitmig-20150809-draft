# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Geo-IP/Geo-IP-1.21.ebuild,v 1.3 2004/03/21 12:04:18 mboman Exp $

inherit perl-module

IUSE=""
DESCRIPTION="Look up country by IP Address"
SRC_URI="http://www.cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${P}.readme"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~sparc"
DEPEND="dev-libs/geoip"
