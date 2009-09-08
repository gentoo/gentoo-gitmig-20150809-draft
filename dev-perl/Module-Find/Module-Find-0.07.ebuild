# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Find/Module-Find-0.07.ebuild,v 1.1 2009/09/08 06:27:16 tove Exp $

EAPI=2

MODULE_AUTHOR="CRENZ"
inherit perl-module

DESCRIPTION="Find and use installed modules in a (sub)category"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do

src_prepare() {
	find "${S}" -type f -name "._*" -delete
	perl-module_src_prepare
}
