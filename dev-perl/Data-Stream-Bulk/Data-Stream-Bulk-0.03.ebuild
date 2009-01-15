# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Stream-Bulk/Data-Stream-Bulk-0.03.ebuild,v 1.1 2009/01/15 11:09:02 tove Exp $

MODULE_AUTHOR=NUFFIN
inherit perl-module

DESCRIPTION="N at a time iteration API"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/Moose
	dev-perl/Sub-Exporter
	dev-perl/Path-Class"

# missing deps
SRC_TEST=no
