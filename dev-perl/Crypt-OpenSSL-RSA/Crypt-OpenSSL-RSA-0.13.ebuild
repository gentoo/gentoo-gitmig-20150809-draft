# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Navid Golpayegani <golpa@atmos.umd.edu>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.5 2002/04/29 22:56:53 sandymac Exp

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::OpenSSL::RSA module for perl"
SRC_URI="http://www.cpan.org/authors/id/I/IR/IROBERTS/${P}.tar.gz"
LICENSE="Artistic | GPL-2"
DEPEND="virtual/glibc 
	>=sys-devel/perl-5 
	dev-perl/Crypt-OpenSSL-Random 
	dev-libs/openssl"

	mydoc="rfc*.txt"
