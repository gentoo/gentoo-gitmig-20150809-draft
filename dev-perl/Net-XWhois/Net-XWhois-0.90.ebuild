# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-XWhois/Net-XWhois-0.90.ebuild,v 1.1 2005/03/13 13:13:16 mcummings Exp $

inherit perl-module

DESCRIPTION="Manipulate netblock lists in CIDR notation"
SRC_URI="mirror://cpan/authors/id/V/VI/VIPUL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/Net-XWhois/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

mydoc="examples/*"
