# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Geo-IP/Geo-IP-1.38.ebuild,v 1.3 2011/06/29 18:50:04 maekke Exp $

EAPI=2

MODULE_AUTHOR=BORISZ
inherit perl-module multilib

DESCRIPTION="Look up country by IP Address"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/geoip"
RDEPEND="${DEPEND}"

SRC_TEST=no
myconf="LIBS=-L/usr/$(get_libdir)"
