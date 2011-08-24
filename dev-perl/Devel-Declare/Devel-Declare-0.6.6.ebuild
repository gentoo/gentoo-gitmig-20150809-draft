# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Declare/Devel-Declare-0.6.6.ebuild,v 1.1 2011/08/24 15:00:07 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.006006
inherit perl-module

DESCRIPTION="Adding keywords to perl, in perl"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Sub-Name
	virtual/perl-Scalar-List-Utils
	>=dev-perl/B-Hooks-OP-Check-0.18
	dev-perl/B-Hooks-EndOfScope"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.302
	test? (
		>=virtual/perl-Test-Simple-0.88
		dev-perl/Test-Warn
	)
"

SRC_TEST=do
