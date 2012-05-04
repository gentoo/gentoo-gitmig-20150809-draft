# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-BrowserDetect/HTTP-BrowserDetect-1.440.0.ebuild,v 1.1 2012/05/04 13:51:38 tove Exp $

EAPI=4

MODULE_AUTHOR=OALDERS
MODULE_VERSION=1.44
inherit perl-module

DESCRIPTION="Detect browser, version, OS from UserAgent"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? (
		dev-perl/Data-Dump
		dev-perl/File-Slurp
		virtual/perl-JSON-PP
	)"

SRC_TEST="do"
