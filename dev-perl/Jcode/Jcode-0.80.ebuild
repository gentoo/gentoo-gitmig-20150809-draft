# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Jcode/Jcode-0.80.ebuild,v 1.4 2002/07/27 18:27:16 aliz Exp $

inherit perl-module

MY_P=Jcode-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Japanese transcoding module for Perl"
SRC_URI="http://cpan.org/modules/by-authors/id/D/DA/DANKOGAI/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-authors/id/D/DA/DANKOGAI/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

newdepend ">=dev-perl/MIME-Base64-2.1"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
