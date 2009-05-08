# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Feed/XML-Feed-0.43.ebuild,v 1.1 2009/05/08 08:36:02 tove Exp $

EAPI=2

MODULE_AUTHOR=SIMONW
inherit perl-module

DESCRIPTION="Syndication feed parser and auto-discovery"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/Class-ErrorHandler
	dev-perl/Feed-Find
	dev-perl/URI-Fetch
	>=dev-perl/XML-RSS-1.44
	>=dev-perl/XML-Atom-0.32
	dev-perl/DateTime
	dev-perl/DateTime-Format-Mail
	dev-perl/DateTime-Format-W3CDTF
	dev-perl/HTML-Parser
	dev-perl/libwww-perl
	virtual/perl-Module-Pluggable"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
