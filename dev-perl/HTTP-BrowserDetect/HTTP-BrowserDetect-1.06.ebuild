# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-BrowserDetect/HTTP-BrowserDetect-1.06.ebuild,v 1.1 2009/11/26 08:02:05 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=OALDERS
inherit perl-module

DESCRIPTION="Detect browser, version, OS from UserAgent"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Data-Dump )"

SRC_TEST="do"
