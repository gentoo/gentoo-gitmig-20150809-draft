# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SimpleUnit/Test-SimpleUnit-1.210.0.ebuild,v 1.3 2011/12/01 16:20:51 tove Exp $

EAPI=4

MODULE_AUTHOR=GED
MODULE_VERSION=1.21
inherit perl-module

DESCRIPTION="Simplified Perl unit-testing framework"

LICENSE="|| ( Artistic GPL-2 GPL-3 )" # Artistic or GPL-2+
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="dev-perl/Data-Compare"
DEPEND="${RDEPEND}
	dev-perl/ExtUtils-AutoInstall"

SRC_TEST="do"
