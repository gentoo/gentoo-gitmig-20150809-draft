# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SSLeay/Crypt-SSLeay-0.51.ebuild,v 1.1 2004/06/05 17:04:08 mcummings Exp $

inherit perl-module

DESCRIPTION="Crypt::SSLeay module for perl"
SRC_URI="http://www.cpan.org/modules/by-module/Crypt/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/CHAMAS/Crypt-SSLeay-${PV}/"
IUSE=""
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc ~sparc ~hppa ~mips ~ia64"

SRC_TEST="do"

DEPEND="virtual/glibc
	>=dev-lang/perl-5
	dev-perl/libwww-perl
	>=dev-libs/openssl-0.9.7c"

export OPTIMIZE="${CFLAGS}"
myconf="${myconf} /usr"

