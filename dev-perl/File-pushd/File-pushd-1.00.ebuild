# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-pushd/File-pushd-1.00.ebuild,v 1.1 2010/02/15 14:05:34 tove Exp $

EAPI=2

MODULE_AUTHOR=DAGOLDEN
inherit perl-module

DESCRIPTION="change directory temporarily for a limited scope"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
