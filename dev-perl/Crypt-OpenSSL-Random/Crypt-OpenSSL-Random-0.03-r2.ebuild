# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-Random/Crypt-OpenSSL-Random-0.03-r2.ebuild,v 1.6 2004/02/21 08:19:56 vapier Exp $

inherit perl-module

DESCRIPTION="Crypt::OpenSSL::Random module for perl"
HOMEPAGE="http://search.cpan.org/author/IROBERTS/Crypt-OpenSSL-Random-${PV}/"
SRC_URI="http://cpan.valueclick.com/authors/id/I/IR/IROBERTS/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"

DEPEND="dev-libs/openssl"

export OPTIMIZE="${CFLAGS}"
mydoc="ToDo"
