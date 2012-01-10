# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Random/Data-Random-0.60.0.ebuild,v 1.1 2012/01/10 18:46:06 tove Exp $

EAPI=4

MODULE_AUTHOR=ADEO
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="A module used to generate random data"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
