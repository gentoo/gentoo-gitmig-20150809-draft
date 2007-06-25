# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-Random/Crypt-OpenSSL-Random-0.04.ebuild,v 1.2 2007/06/25 17:01:56 mcummings Exp $

inherit perl-module

DESCRIPTION="Crypt::OpenSSL::Random module for perl"
HOMEPAGE="http://search.cpan.org/~iroberts/"
SRC_URI="mirror://cpan/authors/id/I/IR/IROBERTS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh sparc ~x86"
IUSE=""

DEPEND="dev-libs/openssl
	dev-lang/perl"

export OPTIMIZE="${CFLAGS}"
mydoc="ToDo"
