# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/i18n-langtags/i18n-langtags-0.27.ebuild,v 1.1 2002/06/17 13:56:19 seemant Exp $

inherit perl-module

MY_P=I18N-LangTags-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="RFC3066 language tag handling for Perl"
LICENSE="Artistic | GPL-2"
SRC_URI="http://www.cpan.org/modules/by-module/I18N/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/I18N/${MY_P}.readme"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
