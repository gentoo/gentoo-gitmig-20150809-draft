# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-BrowserDetect/HTTP-BrowserDetect-1.10.ebuild,v 1.6 2012/03/19 19:36:51 armin76 Exp $

EAPI=2

MODULE_AUTHOR=OALDERS
inherit perl-module

DESCRIPTION="Detect browser, version, OS from UserAgent"

SLOT="0"
KEYWORDS="alpha amd64 hppa ppc x86"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Data-Dump
		dev-perl/YAML-Tiny )"

SRC_TEST="do"
