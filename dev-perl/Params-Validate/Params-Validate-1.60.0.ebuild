# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Validate/Params-Validate-1.60.0.ebuild,v 1.2 2012/02/14 11:28:50 aballier Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="A module to provide a flexible system for validation method/function call parameters"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND="
	virtual/perl-Attribute-Handlers
	dev-perl/Module-Implementation
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.35
	test? (
		dev-perl/Test-Fatal
	)
"

SRC_TEST="do"
