# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IP/Net-IP-1.24.ebuild,v 1.5 2005/12/02 22:39:24 ferdy Exp $

inherit perl-module

DESCRIPTION="Perl extension for manipulating IPv4/IPv6 addresses"
SRC_URI="mirror://cpan/authors/id/M/MA/MANU/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Net::IP"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

mydoc="TODO"
