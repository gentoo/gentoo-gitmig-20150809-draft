# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Pcalc/Date-Pcalc-6.1.ebuild,v 1.3 2010/06/27 19:03:40 nixnut Exp $

EAPI=2

MODULE_AUTHOR=STBEY
inherit perl-module

DESCRIPTION="Gregorian calendar date calculations"

SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 ~s390 ~sparc x86"
IUSE=""

DEPEND=">=dev-perl/Bit-Vector-7
	>=dev-perl/Carp-Clan-5.3"
RDEPEND="${DEPEND}"

SRC_TEST="do"
mydoc="ToDo"
