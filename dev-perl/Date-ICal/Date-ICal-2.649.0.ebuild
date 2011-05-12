# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-ICal/Date-ICal-2.649.0.ebuild,v 1.1 2011/05/12 16:38:55 tove Exp $

EAPI=4

MODULE_AUTHOR=RBOW
MODULE_VERSION=2.649
inherit perl-module

DESCRIPTION="ICal format date base module for Perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Date-Leapyear
	virtual/perl-Time-Local
	virtual/perl-Time-HiRes
	virtual/perl-Storable"
DEPEND="${RDEPEND}"

SRC_TEST="do"
