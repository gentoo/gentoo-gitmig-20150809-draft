# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-HTTP/DateTime-Format-HTTP-0.38.ebuild,v 1.2 2010/01/14 08:56:27 tove Exp $

EAPI=2

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="Date conversion routines"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/DateTime
	dev-perl/libwww-perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
