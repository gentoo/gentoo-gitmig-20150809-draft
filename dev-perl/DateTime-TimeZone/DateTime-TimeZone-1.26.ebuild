# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-TimeZone/DateTime-TimeZone-1.26.ebuild,v 1.3 2010/11/28 19:21:44 armin76 Exp $

EAPI=3

inherit versionator
MY_P=${PN}-$(delete_version_separator 2)
MODULE_AUTHOR=DROLSKY
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Time zone object base class and factory"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Class-Load
	>=dev-perl/Params-Validate-0.72
	>=dev-perl/Class-Singleton-1.03"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.36.01
	test? ( >=virtual/perl-Test-Simple-0.92 )"

SRC_TEST="do"
