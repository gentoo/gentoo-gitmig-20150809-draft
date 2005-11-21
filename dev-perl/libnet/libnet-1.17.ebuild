# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libnet/libnet-1.17.ebuild,v 1.12 2005/11/21 05:46:26 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="A URI Perl Module"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gbarr/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ppc ~sparc alpha ~hppa ia64 s390 ~mips"
IUSE="sasl"

DEPEND="sasl? ( dev-perl/Authen-SASL )"

src_compile() {
	cp ${O}/files/libnet.cfg .
	perl-module_src_compile
}
