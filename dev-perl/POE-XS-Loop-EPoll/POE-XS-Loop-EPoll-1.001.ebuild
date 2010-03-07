# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-XS-Loop-EPoll/POE-XS-Loop-EPoll-1.001.ebuild,v 1.1 2010/03/07 10:44:54 tove Exp $

EAPI=2

MODULE_AUTHOR="TONYC"
inherit perl-module

DESCRIPTION="an XS implementation of POE::Loop, using Linux epoll(2)."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/POE-1.287
	>=dev-perl/POE-Test-Loops-1.033"
RDEPEND="${DEPEND}"

SRC_TEST="do"
