# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-Random/Crypt-OpenSSL-Random-0.03-r1.ebuild,v 1.5 2002/07/25 04:13:23 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::OpenSSL::Random module for perl"
SRC_URI="http://cpan.valueclick.com/authors/id/I/IR/IROBERTS/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

DEPEND="${DEPEND}
	dev-libs/openssl"

export OPTIMIZE="${CFLAGS}"
mydoc="ToDo"
