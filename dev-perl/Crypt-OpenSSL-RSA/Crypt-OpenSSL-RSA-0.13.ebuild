# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-RSA/Crypt-OpenSSL-RSA-0.13.ebuild,v 1.3 2002/08/21 19:58:34 mcummings Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::OpenSSL::RSA module for perl"
SRC_URI="http://www.cpan.org/authors/id/I/IR/IROBERTS/${P}.tar.gz"
LICENSE="Artistic | GPL-2"
DEPEND="virtual/glibc 
	>=sys-devel/perl-5 
	dev-perl/Crypt-OpenSSL-Random 
	dev-libs/openssl"
KEYWORDS="x86"
SLOT="0"

	mydoc="rfc*.txt"
