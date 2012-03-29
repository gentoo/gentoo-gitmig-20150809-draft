# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OOTools/OOTools-2.300.0.ebuild,v 1.1 2012/03/29 17:53:23 tove Exp $

EAPI=4

MODULE_AUTHOR=SKNPP
MODULE_VERSION=2.3
inherit perl-module

DESCRIPTION="Pragma to implement lvalue accessors with options"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	virtual/perl-Module-Build
"

SRC_TEST=do
