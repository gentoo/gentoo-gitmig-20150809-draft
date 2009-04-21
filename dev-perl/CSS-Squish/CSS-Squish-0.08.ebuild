# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CSS-Squish/CSS-Squish-0.08.ebuild,v 1.1 2009/04/21 17:03:03 tove Exp $

EAPI=2

MODULE_AUTHOR=RUZ
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
