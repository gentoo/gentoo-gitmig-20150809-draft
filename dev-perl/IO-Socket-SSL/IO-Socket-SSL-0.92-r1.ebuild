# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-SSL/IO-Socket-SSL-0.92-r1.ebuild,v 1.1 2002/10/30 07:20:38 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"
SRC_URI="http://cpan.valueclick.com/authors/id/B/BE/BEHROOZI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/BEHROOZI/${P}/README"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc sparc64"

DEPEND="${DEPEND} dev-perl/Net-SSLeay"
