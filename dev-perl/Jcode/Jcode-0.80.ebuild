# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Jcode/Jcode-0.80.ebuild,v 1.1 2002/06/28 12:18:04 seemant Exp $

inherit perl-module

MY_P=Jcode-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Japanese transcoding module for Perl"
LICENSE="Artistic | GPL-2"
SRC_URI="http://cpan.org/modules/by-authors/id/D/DA/DANKOGAI/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-authors/id/D/DA/DANKOGAI/${MY_P}.readme"

SLOT=""
newdepend ">=dev-perl/MIME-Base64-2.1"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
