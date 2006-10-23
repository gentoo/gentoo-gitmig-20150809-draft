# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-SSL/IO-Socket-SSL-0.99.9.ebuild,v 1.7 2006/10/23 18:08:13 gustavoz Exp $

inherit perl-module versionator

MY_PV="$(replace_version_separator 2 "" ${PV})"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"
SRC_URI="mirror://cpan/authors/id/S/SU/SULLR/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~sullr/IO-Socket-SSL/"
# http://search.cpan.org/CPAN/authors/id/S/SU/SULLR/IO-Socket-SSL-0.98_1.tar.gz

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

# Disabled because the tests conflict with other services already running on the
# desired ports -and who wants to write a patch to try and locate a free prot
# range just for this?
#SRC_TEST="do"

DEPEND=">=dev-perl/Net-SSLeay-1.21
	dev-lang/perl"
MY_PV=$(replace_version_separator 2 '')
S="${WORKDIR}/${PN}-${MY_PV}"
