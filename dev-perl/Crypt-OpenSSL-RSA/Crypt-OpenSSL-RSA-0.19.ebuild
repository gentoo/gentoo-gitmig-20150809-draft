# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-RSA/Crypt-OpenSSL-RSA-0.19.ebuild,v 1.1 2003/06/07 11:46:06 mcummings Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::OpenSSL::RSA module for perl"
SRC_URI="http://cpan.pair.com/authors/id/I/IR/IROBERTS/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/author/IROBERTS/Crypt-OpenSSL-RSA-${PV}/"
LICENSE="Artistic | GPL-2"
DEPEND="virtual/glibc 
	dev-perl/Crypt-OpenSSL-Random 
	dev-libs/openssl"
KEYWORDS="x86 ~alpha ~sparc ~ppc"
SLOT="0"

mydoc="rfc*.txt"
