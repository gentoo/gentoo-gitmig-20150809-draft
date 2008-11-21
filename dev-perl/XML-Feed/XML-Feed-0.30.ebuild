# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Feed/XML-Feed-0.30.ebuild,v 1.1 2008/11/21 09:00:39 tove Exp $

MY_P=${P/30/3}
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=SIMONW
inherit perl-module

DESCRIPTION="Syndication feed parser and auto-discovery"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl
	dev-perl/Class-ErrorHandler
	dev-perl/Feed-Find
	dev-perl/URI-Fetch
	>=dev-perl/XML-RSS-1.35
	>=dev-perl/XML-Atom-0.28
	dev-perl/DateTime
	dev-perl/DateTime-Format-Mail
	dev-perl/DateTime-Format-W3CDTF
	dev-perl/HTML-Parser
	dev-perl/libwww-perl
	virtual/perl-Module-Pluggable"
#DEPEND="${RDEPEND}
#	virtual/perl-Module-Build"

SRC_TEST=do
