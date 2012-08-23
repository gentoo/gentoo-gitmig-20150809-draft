# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Eval-Closure/Eval-Closure-0.80.0.ebuild,v 1.4 2012/08/23 14:36:18 xmw Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="safely and cleanly create closures via string eval"

SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x64-macos"
IUSE="test"

RDEPEND="
	dev-perl/Sub-Exporter
	dev-perl/Try-Tiny
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Fatal
		dev-perl/Test-Output
		dev-perl/Test-Requires
	)
"

SRC_TEST="do"
