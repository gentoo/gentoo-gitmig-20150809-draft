# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Lite/MIME-Lite-3.01.ebuild,v 1.7 2004/10/16 23:57:22 rac Exp $

IUSE=""

inherit perl-module

DESCRIPTION="low-calorie MIME generator"
SRC_URI="http://www.cpan.org/modules/by-module/MIME/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/ERYQ/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ~ppc sparc alpha"

src_install() {
	perl-module_src_install
	eval `perl '-V:installvendorlib'`
	BUILD_VENDOR_LIB=${D}/${installvendorlib}
	cd ${S}
	cp ${S}/contrib/*.pm ${BUILD_VENDOR_LIB}/
}
