# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Parser/HTML-Parser-3.36.ebuild,v 1.4 2004/07/22 02:40:52 tgall Exp $

inherit perl-module

DESCRIPTION="Parse <HEAD> section of HTML documents"
SRC_URI="http://cpan.org/modules/by-module/HTML/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/HTML/${P}.readme"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~ia64 ppc64"
IUSE=""
DEPEND=">=dev-perl/HTML-Tagset-3.03"
mydoc="ANNOUNCEMENT TODO"

src_compile() {
	if [ "${MMSIXELEVEN}" ]; then
		echo 'n' | perl Makefile.PL ${myconf} \
		PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}
	else
		echo 'n' | perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr INSTALLDIRS=vendor
	fi
	perl-module_src_test
}
