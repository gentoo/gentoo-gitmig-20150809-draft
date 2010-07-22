# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-ArgNames/Devel-ArgNames-0.03.ebuild,v 1.1 2010/07/22 18:12:01 tove Exp $

EAPI=3

MODULE_AUTHOR="NUFFIN"
inherit perl-module

DESCRIPTION="Figure out the names of variables passed into subroutines"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/PadWalker"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-use-ok )"

SRC_TEST="do"
