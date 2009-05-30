# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-XS/JSON-XS-2.2.4.ebuild,v 1.1 2009/05/30 21:13:31 tove Exp $

EAPI=2

inherit versionator
MODULE_AUTHOR=MLEHMANN
MY_P=${PN}-"$(get_major_version).$(delete_all_version_separators $(get_after_major_version))"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="JSON::XS - JSON serialising/deserialising, done correctly and fast"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Harness )"

SRC_TEST="do"
