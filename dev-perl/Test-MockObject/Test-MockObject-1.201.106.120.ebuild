# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-MockObject/Test-MockObject-1.201.106.120.ebuild,v 1.1 2011/06/13 07:24:11 tove Exp $

EAPI=4

MODULE_AUTHOR=CHROMATIC
MODULE_VERSION=1.20110612
inherit perl-module

DESCRIPTION="Perl extension for emulating troublesome interfaces"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/UNIVERSAL-isa-1.03
	>=dev-perl/UNIVERSAL-can-1.16"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Exception-0.31
		>=dev-perl/Test-Warn-0.230.0
	)
"

SRC_TEST=do
