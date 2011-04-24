# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Piece-MySQL/Time-Piece-MySQL-0.06.ebuild,v 1.2 2011/04/24 15:46:11 grobian Exp $

MODULE_AUTHOR="KASEI"

inherit perl-module

DESCRIPTION="MySQL-specific functions for Time::Piece"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~x86-solaris"

DEPEND=">=virtual/perl-Time-Piece-1.15
	dev-lang/perl"
SRC_TEST=do
