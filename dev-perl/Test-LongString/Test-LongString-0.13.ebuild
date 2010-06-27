# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-LongString/Test-LongString-0.13.ebuild,v 1.4 2010/06/27 19:20:33 nixnut Exp $

EAPI=2

MODULE_AUTHOR=RGARCIA
inherit perl-module

DESCRIPTION="A library to test long strings."

SLOT="0"
KEYWORDS="amd64 ia64 ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
