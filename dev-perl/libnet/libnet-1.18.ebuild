# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libnet/libnet-1.18.ebuild,v 1.4 2004/08/31 13:29:05 mcummings Exp $

inherit perl-module

DESCRIPTION="A URI Perl Module"
SRC_URI="http://search.cpan.org/CPAN/authors/id/G/GB/GBARR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gbarr/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~ia64 ~s390"
IUSE=""

src_compile() {
	cp ${O}/files/libnet.cfg .
	perl-module_src_compile
}
