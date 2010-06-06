# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Types-JSON/MooseX-Types-JSON-0.02.ebuild,v 1.1 2010/06/06 13:52:02 tove Exp $

EAPI=3

MODULE_AUTHOR="MILA"
inherit perl-module

DESCRIPTION="JSON datatype for Moose"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/JSON-XS-2.00
	>=dev-perl/Moose-0.82
	>=dev-perl/MooseX-Types-0.15"
DEPEND="${RDEPEND}"

SRC_TEST="do"
