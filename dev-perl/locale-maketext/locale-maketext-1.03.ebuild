# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext/locale-maketext-1.03.ebuild,v 1.4 2002/07/27 18:27:16 aliz Exp $

inherit perl-module

MY_P=Locale-Maketext-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Localization framework for Perl programs"
SRC_URI="http://www.cpan.org/modules/by-module/Locale/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Locale/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

DEPEND="${DEPEND}
	>=dev-perl/i18n-langtags-0.21"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
