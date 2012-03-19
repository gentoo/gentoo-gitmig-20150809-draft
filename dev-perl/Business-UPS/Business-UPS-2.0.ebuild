# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-UPS/Business-UPS-2.0.ebuild,v 1.11 2012/03/19 19:26:22 armin76 Exp $

MODULE_AUTHOR=JWHEELER
inherit perl-module

DESCRIPTION="A UPS Interface Module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
