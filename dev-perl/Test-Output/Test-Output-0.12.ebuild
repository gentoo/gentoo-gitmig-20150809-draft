# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Output/Test-Output-0.12.ebuild,v 1.1 2009/01/23 08:50:35 tove Exp $

MODULE_AUTHOR=SSORICHE
inherit perl-module

DESCRIPTION="Utilities to test STDOUT and STDERR messages"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE="test"

RDEPEND="dev-lang/perl
	dev-perl/Sub-Exporter
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Tester )"

SRC_TEST=do
