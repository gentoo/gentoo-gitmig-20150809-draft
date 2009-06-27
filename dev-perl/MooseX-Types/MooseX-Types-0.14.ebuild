# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Types/MooseX-Types-0.14.ebuild,v 1.1 2009/06/27 16:12:01 tove Exp $

EAPI=2

MODULE_AUTHOR=RKITOVER
inherit perl-module

DESCRIPTION="Organise your Moose types in libraries"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Moose-0.61
	dev-perl/Sub-Name
	>=dev-perl/Carp-Clan-6.00
	>=dev-perl/Sub-Install-0.924
	>=dev-perl/namespace-clean-0.08"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Exception )"

SRC_TEST=do
