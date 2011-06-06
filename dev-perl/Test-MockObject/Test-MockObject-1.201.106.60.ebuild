# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-MockObject/Test-MockObject-1.201.106.60.ebuild,v 1.1 2011/06/06 11:45:04 tove Exp $

EAPI=4

MODULE_AUTHOR=CHROMATIC
MODULE_VERSION=1.20110606
inherit perl-module

DESCRIPTION="Perl extension for emulating troublesome interfaces"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/UNIVERSAL-isa-0.06
	>=dev-perl/UNIVERSAL-can-1.11"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Exception-0.31
		>=dev-perl/Test-Warn-0.230.0
	)
"

SRC_TEST=do
