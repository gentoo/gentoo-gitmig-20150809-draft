# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext/locale-maketext-1.06.ebuild,v 1.6 2004/10/16 23:57:25 rac Exp $

inherit perl-module

MY_P=Locale-Maketext-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Localization framework for Perl programs"
SRC_URI="http://www.cpan.org/modules/by-module/Locale/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Locale/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/i18n-langtags-0.21"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
