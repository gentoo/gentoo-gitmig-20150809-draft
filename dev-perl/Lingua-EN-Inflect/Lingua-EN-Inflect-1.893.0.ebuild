# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-Inflect/Lingua-EN-Inflect-1.893.0.ebuild,v 1.7 2012/03/25 16:23:41 armin76 Exp $

EAPI=4

MODULE_AUTHOR=DCONWAY
MODULE_VERSION=1.893
inherit perl-module

DESCRIPTION="Perl module for Lingua::EN::Inflect"

SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
