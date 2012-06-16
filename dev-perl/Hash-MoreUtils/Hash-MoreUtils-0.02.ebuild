# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Hash-MoreUtils/Hash-MoreUtils-0.02.ebuild,v 1.2 2012/06/16 20:08:08 flameeyes Exp $

EAPI="4"

MODULE_AUTHOR="REHSACK"

inherit perl-module

SRC_TEST="do"

DESCRIPTION="Provide the stuff missing in Hash::Util"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
