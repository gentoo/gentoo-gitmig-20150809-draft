# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/string-crc32/string-crc32-1.4.ebuild,v 1.14 2007/10/23 11:00:10 flameeyes Exp $

inherit perl-module

MY_P=String-CRC32-${PV}
DESCRIPTION="Perl interface for cyclic redundancy check generation"
SRC_URI="mirror://cpan/authors/id/S/SO/SOENKE/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SO/SOENKE/${MY_P}.readme"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND="dev-lang/perl"
