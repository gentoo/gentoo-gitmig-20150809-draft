# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPIx-Regexp/PPIx-Regexp-0.009.ebuild,v 1.1 2010/08/05 06:49:30 tove Exp $

EAPI=2

MODULE_AUTHOR=WYANT
inherit perl-module

DESCRIPTION="Represent a regular expression of some sort"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/List-MoreUtils
	dev-perl/Readonly
	dev-perl/PPI
	dev-perl/Params-Util
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
