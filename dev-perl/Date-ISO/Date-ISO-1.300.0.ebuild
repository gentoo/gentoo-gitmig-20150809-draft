# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-ISO/Date-ISO-1.300.0.ebuild,v 1.2 2011/09/03 21:04:50 tove Exp $

EAPI=4

MODULE_AUTHOR=RBOW
MODULE_VERSION=1.30
inherit perl-module

DESCRIPTION="Date::ICal subclass that handles ISO format dates"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/Date-Leapyear
	virtual/perl-Test-Simple
	dev-perl/Date-ICal
	virtual/perl-Memoize"
DEPEND="${RDEPEND}"

SRC_TEST="do"
