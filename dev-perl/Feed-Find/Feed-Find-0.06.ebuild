# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Feed-Find/Feed-Find-0.06.ebuild,v 1.3 2009/11/23 12:18:48 tove Exp $

EAPI=2

MODULE_AUTHOR="BTROTT"
inherit perl-module

DESCRIPTION="Syndication feed auto-discovery"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/URI
	dev-perl/HTML-Parser
	dev-perl/Class-ErrorHandler
	dev-perl/libwww-perl"
DEPEND="${RDEPEND}"

SRC_TEST=online
PREFER_BUILDPL="no"
