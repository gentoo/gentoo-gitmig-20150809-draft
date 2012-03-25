# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Validate/Params-Validate-1.60.0.ebuild,v 1.6 2012/03/25 14:10:26 ranger Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="A module to provide a flexible system for validation method/function call parameters"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
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
