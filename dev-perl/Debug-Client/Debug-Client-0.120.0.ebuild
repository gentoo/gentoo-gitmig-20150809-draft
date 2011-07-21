# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Debug-Client/Debug-Client-0.120.0.ebuild,v 1.1 2011/07/21 18:06:23 tove Exp $

EAPI=4

MODULE_AUTHOR=SZABGAB
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Client side code for perl debugger"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="test? (
		dev-perl/File-HomeDir
		dev-perl/Test-Deep
	)"

SRC_TEST=do
