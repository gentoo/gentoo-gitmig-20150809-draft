# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-SSL/IO-Socket-SSL-0.97.ebuild,v 1.13 2006/08/19 17:49:05 mcummings Exp $

inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"
SRC_URI="mirror://cpan/authors/id/B/BE/BEHROOZI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~behroozi/${P}/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

# Disabled because the tests conflict with other services already running on the
# desired ports -and who wants to write a patch to try and locate a free prot
# range just for this?
#SRC_TEST="do"

DEPEND=">=dev-perl/Net-SSLeay-1.21
	dev-lang/perl"
