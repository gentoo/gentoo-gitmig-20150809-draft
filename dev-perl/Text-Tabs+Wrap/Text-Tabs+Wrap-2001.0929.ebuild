# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Tabs+Wrap/Text-Tabs+Wrap-2001.0929.ebuild,v 1.3 2004/06/25 01:05:49 agriffis Exp $

inherit perl-module

MY_P=Text-Tabs+Wrap-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Expand/unexpand tabs per unix expand and line wrapping"
SRC_URI="http://www.cpan.org/modules/by-module/Text/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Text/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha ~amd64"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
