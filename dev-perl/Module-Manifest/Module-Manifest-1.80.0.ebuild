# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Manifest/Module-Manifest-1.80.0.ebuild,v 1.1 2011/08/29 17:58:43 tove Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.08
inherit perl-module

DESCRIPTION="Parse and examine a Perl distribution MANIFEST file"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Params-Util-0.10
	>=virtual/perl-File-Spec-0.80
"
DEPEND="
	test? (	${RDEPEND}
		>=virtual/perl-Test-Simple-0.42
		>=dev-perl/Test-Exception-0.27
		>=dev-perl/Test-Warn-0.11
	)
"

SRC_TEST=do
