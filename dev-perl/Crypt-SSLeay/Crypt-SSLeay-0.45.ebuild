# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SSLeay/Crypt-SSLeay-0.45.ebuild,v 1.8 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::SSLeay module for perl"
SRC_URI="http://www.cpan.org/authors/id/C/CH/CHAMAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/CHAMAS/Crypt-SSLeay-${PV}/"
IUSE=""
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 alpha"

DEPEND="virtual/glibc 
	>=dev-lang/perl-5
	dev-perl/libwww-perl
	>=dev-libs/openssl-0.9.6g"

export OPTIMIZE="${CFLAGS}"
myconf="${myconf} /usr"

