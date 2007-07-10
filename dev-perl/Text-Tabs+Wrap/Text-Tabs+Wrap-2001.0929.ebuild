# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Tabs+Wrap/Text-Tabs+Wrap-2001.0929.ebuild,v 1.15 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module

MY_P=Text-Tabs+Wrap-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Expand/unexpand tabs per unix expand and line wrapping"
SRC_URI="mirror://cpan/authors/id/M/MU/MUIR/modules/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Text/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
