# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Feed-Find/Feed-Find-0.06.ebuild,v 1.1 2008/08/01 14:41:09 tove Exp $

MODULE_AUTHOR="BTROTT"
inherit perl-module

DESCRIPTION="Syndication feed auto-discovery"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/URI
	dev-perl/HTML-Parser
	dev-perl/Class-ErrorHandler
	dev-perl/libwww-perl"

SRC_TEST=do
