# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SSLeay/Crypt-SSLeay-0.51.ebuild,v 1.6 2004/12/29 08:53:21 corsair Exp $

inherit perl-module

DESCRIPTION="Crypt::SSLeay module for perl"
SRC_URI="http://www.cpan.org/modules/by-module/Crypt/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/CHAMAS/Crypt-SSLeay-${PV}/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc ~sparc ~hppa ~mips ~ia64 ~ppc64"

SRC_TEST="do"

DEPEND="virtual/libc
	>=dev-lang/perl-5
	dev-perl/libwww-perl
	>=dev-libs/openssl-0.9.7c"

export OPTIMIZE="${CFLAGS}"
myconf="${myconf} /usr"
