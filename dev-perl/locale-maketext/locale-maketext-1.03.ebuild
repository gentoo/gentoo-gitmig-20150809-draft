# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext/locale-maketext-1.03.ebuild,v 1.2 2002/07/25 04:13:27 seemant Exp $

inherit perl-module

MY_P=Locale-Maketext-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Localization framework for Perl programs"
LICENSE="Artistic | GPL-2"
SLOT="0"
DEPEND="${DEPEND}
        >=dev-perl/i18n-langtags-0.21"
SRC_URI="http://www.cpan.org/modules/by-module/Locale/${MY_P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Locale/${MY_P}.readme"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
