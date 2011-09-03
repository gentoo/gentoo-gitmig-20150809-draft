# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SimpleUnit/Test-SimpleUnit-1.210.0.ebuild,v 1.2 2011/09/03 21:05:07 tove Exp $

EAPI=4

MODULE_AUTHOR=GED
MODULE_VERSION=1.21
inherit perl-module

DESCRIPTION="Simplified Perl unit-testing framework"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/ExtUtils-AutoInstall
	dev-perl/Data-Compare
	dev-lang/perl"
