# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-UPS/Business-UPS-2.0.ebuild,v 1.10 2009/11/23 16:43:15 tove Exp $

MODULE_AUTHOR=JWHEELER
inherit perl-module

DESCRIPTION="A UPS Interface Module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
