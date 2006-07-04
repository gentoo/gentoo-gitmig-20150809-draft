# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SSLeay/Crypt-SSLeay-0.49.ebuild,v 1.17 2006/07/04 07:06:09 ian Exp $

inherit perl-module

DESCRIPTION="Crypt::SSLeay module for perl"
SRC_URI="mirror://cpan/authors/id/C/CH/CHAMAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~chamas/${P}/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha ppc sparc hppa mips ia64"

DEPEND="virtual/libc
	>=dev-lang/perl-5
	dev-perl/libwww-perl
	>=dev-libs/openssl-0.9.6g"
RDEPEND="${DEPEND}"

export OPTIMIZE="${CFLAGS}"
myconf="${myconf} /usr"
