# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-XS/JSON-XS-2.2.3.2.ebuild,v 1.1 2009/02/23 10:03:43 robbat2 Exp $

inherit versionator
MODULE_AUTHOR=MLEHMANN
MY_P=${PN}-"$(get_major_version).$(delete_all_version_separators $(get_after_major_version))"
inherit perl-module

DESCRIPTION="JSON::XS - JSON serialising/deserialising, done correctly and fast"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Harness )"

S=${WORKDIR}/${MY_P}

SRC_TEST="do"
