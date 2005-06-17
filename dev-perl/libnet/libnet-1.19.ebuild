# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libnet/libnet-1.19.ebuild,v 1.12 2005/06/17 20:45:53 hansmi Exp $

inherit perl-module

DESCRIPTION="A URI Perl Module"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gbarr/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

src_compile() {
	cp ${O}/files/libnet.cfg .
	perl-module_src_compile
}
