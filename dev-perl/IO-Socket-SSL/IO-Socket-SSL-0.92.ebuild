# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-SSL/IO-Socket-SSL-0.92.ebuild,v 1.9 2005/01/04 13:17:03 mcummings Exp $

inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"
SRC_URI="mirror://cpan/authors/id/B/BE/BEHROOZI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~behroozi/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 sparc"
IUSE=""

DEPEND="${DEPEND} dev-perl/Net-SSLeay"
