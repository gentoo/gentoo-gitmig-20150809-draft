# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-GlobalDestruction/Devel-GlobalDestruction-0.02.ebuild,v 1.2 2009/10/26 13:50:59 volkmar Exp $

MODULE_AUTHOR=NUFFIN
inherit perl-module

DESCRIPTION="Expose PL_dirty, the flag which marks global destruction"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/Sub-Exporter
	dev-perl/Scope-Guard"
