# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IP-Country/IP-Country-2.19.ebuild,v 1.3 2006/07/04 11:26:10 ian Exp $

inherit perl-module

DESCRIPTION="fast lookup of country codes from IP addresses"
SRC_URI="mirror://cpan/authors/id/N/NW/NWETTERS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~nwetters/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Geography-Countries"
RDEPEND="${DEPEND}"
mydoc="TODO"