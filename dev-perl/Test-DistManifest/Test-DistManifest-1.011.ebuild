# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-DistManifest/Test-DistManifest-1.011.ebuild,v 1.1 2012/02/26 13:33:58 jlec Exp $

EAPI=4

MODULE_AUTHOR=JAWNSY
MODULE_VERSION=1.011
inherit perl-module

DESCRIPTION="Author test that validates a package MANIFEST"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	dev-perl/Module-Manifest
	dev-perl/Test-NoWarnings
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
