# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Piece-MySQL/Time-Piece-MySQL-0.06.ebuild,v 1.1 2009/11/14 10:50:44 robbat2 Exp $

MODULE_AUTHOR="KASEI"

inherit perl-module

DESCRIPTION="MySQL-specific functions for Time::Piece"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/perl-Time-Piece-1.15
	dev-lang/perl"
SRC_TEST=do
