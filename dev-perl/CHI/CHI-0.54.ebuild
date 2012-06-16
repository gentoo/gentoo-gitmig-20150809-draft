# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CHI/CHI-0.54.ebuild,v 1.1 2012/06/16 21:02:58 flameeyes Exp $

EAPI="4"

MODULE_AUTHOR="JSWARTZ"

inherit perl-module

SRC_TEST="do"

DESCRIPTION="Unified cache handling interface"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-perl/Hash-MoreUtils
	>=dev-perl/Carp-Assert-0.200.0
	dev-perl/String-RewritePrefix
	>=dev-perl/Log-Any-0.140.0
	>=dev-perl/List-MoreUtils-0.330.0
	dev-perl/Task-Weaken
	dev-perl/Moose
	>=dev-perl/Try-Tiny-0.110.0
	>=dev-perl/Time-Duration-Parse-0.60.0
	>=dev-perl/Time-Duration-1.60.0
	dev-perl/Data-UUID
	dev-perl/Digest-JHash
	dev-perl/TimeDate
	dev-perl/JSON"

DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Deep
		dev-perl/Test-Exception
		dev-perl/Test-Class
		dev-perl/Test-Warn
	)"
