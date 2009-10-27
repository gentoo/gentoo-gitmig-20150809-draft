# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-BrowserDetect/HTTP-BrowserDetect-1.03.ebuild,v 1.2 2009/10/27 09:34:39 jer Exp $

EAPI=2

MODULE_AUTHOR=OALDERS
inherit perl-module

DESCRIPTION="Detect browser, version, OS from UserAgent"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Data-Dump )"

SRC_TEST="do"
