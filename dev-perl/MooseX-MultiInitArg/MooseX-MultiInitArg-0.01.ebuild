# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-MultiInitArg/MooseX-MultiInitArg-0.01.ebuild,v 1.1 2009/10/10 13:12:23 tove Exp $

EAPI=2

MODULE_AUTHOR=FRODWITH
inherit perl-module

DESCRIPTION="Attributes with aliases for constructor arguments"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Moose"
DEPEND="test? ( ${DEPEND}
		dev-perl/Test-Pod )"

SRC_TEST="do"
