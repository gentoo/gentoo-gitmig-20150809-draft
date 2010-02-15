# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Debug-Client/Debug-Client-0.11.ebuild,v 1.1 2010/02/15 12:36:13 tove Exp $

EAPI=2

MODULE_AUTHOR=SZABGAB
inherit perl-module

DESCRIPTION="Client side code for perl debugger"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Deep )"

SRC_TEST=do
