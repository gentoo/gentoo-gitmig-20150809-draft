# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MARC-Record/MARC-Record-2.0.1.ebuild,v 1.1 2010/05/02 09:54:46 tove Exp $

EAPI=3

MODULE_AUTHOR=GMCHARLT
inherit perl-module

DESCRIPTION="MARC manipulation (library bibliographic)"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
