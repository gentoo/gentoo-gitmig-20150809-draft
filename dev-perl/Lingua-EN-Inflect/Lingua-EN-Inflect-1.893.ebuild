# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-Inflect/Lingua-EN-Inflect-1.893.ebuild,v 1.1 2011/01/14 12:20:26 tove Exp $

EAPI=3

MODULE_AUTHOR="DCONWAY"
inherit perl-module

DESCRIPTION="Perl module for Lingua::EN::Inflect"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
