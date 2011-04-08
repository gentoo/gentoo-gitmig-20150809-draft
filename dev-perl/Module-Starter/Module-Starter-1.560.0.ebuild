# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Starter/Module-Starter-1.560.0.ebuild,v 1.1 2011/04/08 09:24:30 tove Exp $

EAPI=4

MODULE_AUTHOR=XSAWYERX
MODULE_VERSION=1.56
inherit perl-module

DESCRIPTION="A simple starter kit for any module"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-File-Spec
	virtual/perl-Getopt-Long
	>=virtual/perl-PodParser-1.21
"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
		>=virtual/perl-Test-Harness-0.21
	)
"

SRC_TEST=do
