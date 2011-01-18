# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CSS-Squish/CSS-Squish-0.100.ebuild,v 1.1 2011/01/18 07:38:46 tove Exp $

EAPI=3

MODULE_AUTHOR=TSIBLEY
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Compact many CSS files into one big file"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="dev-perl/URI
	virtual/perl-File-Spec"
DEPEND="test? ( ${RDEPEND}
		dev-perl/Test-LongString )"

SRC_TEST="do"
