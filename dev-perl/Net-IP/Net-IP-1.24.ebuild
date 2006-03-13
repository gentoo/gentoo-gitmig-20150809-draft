# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IP/Net-IP-1.24.ebuild,v 1.14 2006/03/13 21:18:27 chriswhite Exp $

inherit perl-module

DESCRIPTION="Perl extension for manipulating IPv4/IPv6 addresses"
SRC_URI="mirror://cpan/authors/id/M/MA/MANU/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Net::IP"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"

mydoc="TODO"
