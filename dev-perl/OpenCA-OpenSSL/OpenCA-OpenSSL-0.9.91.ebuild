# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-OpenSSL/OpenCA-OpenSSL-0.9.91.ebuild,v 1.2 2004/06/06 22:26:48 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The perl OpenCA::SSL Module"
SRC_URI="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~s390"

export OPTIMIZE="${CFLAGS}"

DEPEND="dev-perl/X500-DN
	dev-libs/openssl"
