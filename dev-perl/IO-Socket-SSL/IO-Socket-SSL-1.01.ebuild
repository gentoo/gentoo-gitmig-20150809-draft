# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-SSL/IO-Socket-SSL-1.01.ebuild,v 1.5 2006/12/24 00:46:31 dertobi123 Exp $

inherit perl-module versionator

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"
HOMEPAGE="http://search.cpan.org/~sullr/IO-Socket-SSL/"
SRC_URI="mirror://cpan/authors/id/S/SU/SULLR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ia64 ~mips ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-perl/Net-SSLeay-1.21
	dev-lang/perl"

# Disabled because the tests conflict with other services already running on the
# desired ports -and who wants to write a patch to try and locate a free prot
# range just for this?
#SRC_TEST="do"
