# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-TimeZone/DateTime-TimeZone-1.270.ebuild,v 1.1 2011/01/25 11:16:57 tove Exp $

EAPI=3

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.27
inherit perl-module

DESCRIPTION="Time zone object base class and factory"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~s390 ~sh ~sparc ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Class-Load
	>=dev-perl/Params-Validate-0.72
	>=dev-perl/Class-Singleton-1.03"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.36.01
	test? ( >=virtual/perl-Test-Simple-0.92 )"

SRC_TEST="do"
