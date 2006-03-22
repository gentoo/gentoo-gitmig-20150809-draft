# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IP-Country/IP-Country-2.20.ebuild,v 1.5 2006/03/22 20:43:43 flameeyes Exp $

inherit perl-module

DESCRIPTION="fast lookup of country codes from IP addresses"
SRC_URI="mirror://cpan/authors/id/N/NW/NWETTERS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~nwetters/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Geography-Countries"
mydoc="TODO"
