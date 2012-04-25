# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-DistManifest/Test-DistManifest-1.12.0.ebuild,v 1.1 2012/04/25 16:31:53 tove Exp $

EAPI=4

MODULE_AUTHOR=ETHER
MODULE_VERSION=1.012
inherit perl-module

DESCRIPTION="Author test that validates a package MANIFEST"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	dev-perl/Module-Manifest
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-NoWarnings
	)
"

SRC_TEST="do"
