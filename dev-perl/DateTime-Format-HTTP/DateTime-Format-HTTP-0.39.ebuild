# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-HTTP/DateTime-Format-HTTP-0.39.ebuild,v 1.1 2010/07/15 14:21:37 tove Exp $

EAPI=3

MODULE_AUTHOR=CKRAS
inherit perl-module

DESCRIPTION="Date conversion routines"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/DateTime
	dev-perl/libwww-perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
