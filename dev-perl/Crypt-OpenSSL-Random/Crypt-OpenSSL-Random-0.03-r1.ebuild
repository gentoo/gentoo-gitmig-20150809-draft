# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-Random/Crypt-OpenSSL-Random-0.03-r1.ebuild,v 1.13 2003/02/13 11:02:08 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::OpenSSL::Random module for perl"
SRC_URI="http://cpan.valueclick.com/authors/id/I/IR/IROBERTS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/IROBERTS/Crypt-OpenSSL-Random-${PV}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-libs/openssl"

export OPTIMIZE="${CFLAGS}"
mydoc="ToDo"
