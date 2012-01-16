# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS/XML-RSS-1.490.0.ebuild,v 1.4 2012/01/16 14:53:27 ago Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=1.49
inherit perl-module

DESCRIPTION="a basic framework for creating and maintaining RSS files"
HOMEPAGE="http://perl-rss.sourceforge.net/"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-perl/HTML-Parser
	dev-perl/DateTime-Format-Mail
	dev-perl/DateTime-Format-W3CDTF
	>=dev-perl/XML-Parser-2.30"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		>=dev-perl/Test-Manifest-0.9 )"
		#dev-perl/Test-Differences
