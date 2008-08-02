# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RTF-Writer/RTF-Writer-1.11.ebuild,v 1.3 2008/08/02 20:21:28 tove Exp $

MODULE_AUTHOR=SBURKE
inherit perl-module

DESCRIPTION="RTF::Writer - for generating documents in Rich Text Format"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86"
IUSE="test"
SRC_TEST="do"

RDEPEND="dev-lang/perl
	dev-perl/ImageSize"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Harness )"
