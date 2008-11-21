# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-XS/JSON-XS-2.2.3.1.ebuild,v 1.1 2008/11/21 10:13:40 tove Exp $

MODULE_AUTHOR=MLEHMANN
inherit perl-module versionator

MY_P=${PN}-"$(get_major_version).$(delete_all_version_separators $(get_after_major_version))"
S=${WORKDIR}/${MY_P}

DESCRIPTION="JSON::XS - JSON serialising/deserialising, done correctly and fast"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
IUSE="test"
SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Harness )"
