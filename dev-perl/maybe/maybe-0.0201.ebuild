# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/maybe/maybe-0.0201.ebuild,v 1.3 2009/11/24 07:04:51 tove Exp $

EAPI=2
MODULE_AUTHOR="DEXTER"

inherit perl-module

DESCRIPTION="Use a Perl module and ignore error if can't be loaded"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
