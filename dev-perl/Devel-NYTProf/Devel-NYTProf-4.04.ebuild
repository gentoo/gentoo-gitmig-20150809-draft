# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-NYTProf/Devel-NYTProf-4.04.ebuild,v 1.1 2010/07/16 06:34:30 tove Exp $

EAPI=2

MODULE_AUTHOR=TIMB
inherit perl-module

DESCRIPTION="Powerful feature-rich perl source code profiler"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Getopt-Long
	dev-perl/JSON-Any
"
#	virtual/perl-XSLoader
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Scalar-List-Utils
		>=virtual/perl-Test-Simple-0.84
	)
"
SRC_TEST="do"
