# ChangeLog for home/OpenCA-OpenSSL-0.8.43.ebuild
# Copyright 2002 Gentoo Technologies, Inc.; Distributed under the GPL
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-OpenSSL/OpenCA-OpenSSL-0.8.43.ebuild,v 1.3 2002/07/25 04:43:33 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The perl OpenCA::SSL Module"
SRC_URI="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

export OPTIMIZE="${CFLAGS}"
