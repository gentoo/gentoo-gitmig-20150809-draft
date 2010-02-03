# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Died/Exception-Died-0.06.ebuild,v 1.4 2010/02/03 11:46:29 tove Exp $

EAPI=2

MODULE_AUTHOR="DEXTER"
inherit perl-module

DESCRIPTION="Convert simple die into real exception object"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/constant-boolean
	>=dev-perl/Exception-Base-0.22.01"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
#	test? ( virtual/perl-parent
#		>=dev-perl/Test-Unit-Lite-0.12
#		>=dev-perl/Test-Assert-0.0501 )"
