# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-X509/OpenCA-X509-0.9.8.ebuild,v 1.2 2002/07/25 04:13:27 seemant Exp $

inherit perl-module
S=${WORKDIR}/${P}
DESCRIPTION="The perl OpenCA::X509 Module"
SRC_URI="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.tar.gz"
SLOT="0"
LICENSE="Artistic | GPL-2"
SLOT="0"
export OPTIMIZE="${CFLAGS}"
