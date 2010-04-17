# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Compare/Data-Compare-1.22.ebuild,v 1.2 2010/04/17 08:52:51 tove Exp $

EAPI=2
#inherit versionator
#MY_P=${PN}-$(delete_version_separator 2)
#S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=DCANTRELL
inherit perl-module

DESCRIPTION="compare perl data structures"

SLOT="0"
KEYWORDS="amd64 ~hppa ~ia64 ~ppc ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-perl/File-Find-Rule
	dev-perl/Scalar-Properties"
DEPEND="${RDEPEND}
	test? ( dev-perl/Clone
		dev-perl/Test-Pod )"

SRC_TEST="do"
