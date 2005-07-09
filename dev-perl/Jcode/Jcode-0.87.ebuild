# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Jcode/Jcode-0.87.ebuild,v 1.6 2005/07/09 23:07:09 swegener Exp $

inherit perl-module

MY_P=Jcode-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Japanese transcoding module for Perl"
SRC_URI="http://cpan.org/modules/by-authors/id/D/DA/DANKOGAI/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-authors/id/D/DA/DANKOGAI/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~ia64 ~ppc64"
IUSE=""

DEPEND=">=perl-core/MIME-Base64-2.1"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
