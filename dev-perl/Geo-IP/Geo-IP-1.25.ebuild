# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Geo-IP/Geo-IP-1.25.ebuild,v 1.4 2005/08/13 23:22:09 hansmi Exp $

inherit perl-module multilib

IUSE=""
DESCRIPTION="Look up country by IP Address"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/T/TJ/TJMATHER/${P}.readme"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="ppc sparc x86"
DEPEND="dev-libs/geoip"

myconf="${myconf} LIBS='-L/usr/$(get_libdir)'"
