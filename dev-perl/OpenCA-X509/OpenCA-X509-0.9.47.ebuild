# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-X509/OpenCA-X509-0.9.47.ebuild,v 1.2 2005/08/25 23:59:46 agriffis Exp $

inherit perl-module

DESCRIPTION="The perl OpenCA::X509 Module"
SRC_URI="mirror://cpan/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
export OPTIMIZE="${CFLAGS}"

src_compile() {

	cd ${S}
	cp Makefile.PL Makefile.PL.bak
	sed -e "s|'OpenCA::OpenSSL'|{'OpenCA::OpenSSL'}|g" Makefile.PL.bak > Makefile.PL
	perl-module_src_compile

}
