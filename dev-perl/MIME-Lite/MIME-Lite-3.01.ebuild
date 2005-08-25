# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Lite/MIME-Lite-3.01.ebuild,v 1.10 2005/08/25 23:27:06 agriffis Exp $

IUSE=""

inherit perl-module

DESCRIPTION="low-calorie MIME generator"
SRC_URI="mirror://cpan/authors/id/Y/YV/YVES/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/ERYQ/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"

src_install() {
	perl-module_src_install
	eval `perl '-V:installvendorlib'`
	BUILD_VENDOR_LIB=${D}/${installvendorlib}
	cd ${S}
	cp ${S}/contrib/*.pm ${BUILD_VENDOR_LIB}/
}
