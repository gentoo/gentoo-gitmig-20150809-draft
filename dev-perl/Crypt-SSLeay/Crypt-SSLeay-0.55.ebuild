# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SSLeay/Crypt-SSLeay-0.55.ebuild,v 1.7 2007/08/25 13:17:25 vapier Exp $

inherit perl-module

DESCRIPTION="Crypt::SSLeay module for perl"
SRC_URI="mirror://cpan/authors/id/D/DL/DLAND/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dland/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

# Disabling tests for now. Opening a port always leads to mixed results for
# folks - bug 59554
# nb. Re-enabled tests, seem to be better written now, keeping an eye on bugs
# for this though.
SRC_TEST="do"

DEPEND="virtual/libc
	>=dev-lang/perl-5
	>=dev-libs/openssl-0.9.7c"
PDEPEND="dev-perl/libwww-perl"

export OPTIMIZE="${CFLAGS}"
myconf="${myconf} /usr"
