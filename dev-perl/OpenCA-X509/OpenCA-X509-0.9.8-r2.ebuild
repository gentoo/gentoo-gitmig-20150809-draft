# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-X509/OpenCA-X509-0.9.8-r2.ebuild,v 1.11 2006/12/11 11:51:42 yuval Exp $

inherit perl-module

DESCRIPTION="The perl OpenCA::X509 Module"
SRC_URI="mirror://cpan/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~madwolf/${P}/X509.pm"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""
export OPTIMIZE="${CFLAGS}"

src_compile() {

	cd ${S}
	cp Makefile.PL Makefile.PL.bak
	sed -e "s|'OpenCA::OpenSSL'|{'OpenCA::OpenSSL'}|g" Makefile.PL.bak > Makefile.PL
	perl-module_src_compile

}


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
