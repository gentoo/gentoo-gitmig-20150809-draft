# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::SSLeay module for perl"
SRC_URI="http://www.cpan.org/authors/id/C/CH/CHAMAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/CHAMAS/Crypt-SSLeay-${PV}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc 
	>=sys-devel/perl-5
	dev-perl/libwww-perl
	>=dev-libs/openssl-0.9.6g"

export OPTIMIZE="${CFLAGS}"
myconf="${myconf} /usr"

