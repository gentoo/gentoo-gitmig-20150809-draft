# ChangeLog for home/OpenCA-OpenSSL-0.8.43.ebuild
# Copyright 2002 Gentoo Technologies, Inc.; Distributed under the GPL
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-OpenSSL/OpenCA-OpenSSL-0.8.43.ebuild,v 1.1 2002/06/24 17:27:24 lamer Exp $

inherit perl-module
S=${WORKDIR}/${P}
DESCRIPTION="The perl OpenCA::SSL Module"
SRC_URI="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.tar.gz"
LICENSE="Artistic | GPL-2"
SLOT="0"
export OPTIMIZE="${CFLAGS}"
