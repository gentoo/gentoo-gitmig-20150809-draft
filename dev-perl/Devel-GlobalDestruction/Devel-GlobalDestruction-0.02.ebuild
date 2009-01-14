# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-GlobalDestruction/Devel-GlobalDestruction-0.02.ebuild,v 1.1 2009/01/14 10:24:20 tove Exp $

MODULE_AUTHOR=NUFFIN
inherit perl-module

DESCRIPTION="Expose PL_dirty, the flag which marks global destruction"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/Sub-Exporter
	dev-perl/Scope-Guard"
