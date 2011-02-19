# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Format/HTML-Format-2.50.ebuild,v 1.1 2011/02/19 08:32:40 tove Exp $

EAPI=3

MODULE_AUTHOR=NIGELM
MODULE_VERSION=2.05
inherit perl-module

DESCRIPTION="HTML Formatter"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="
	dev-perl/File-Slurp
	dev-perl/Font-AFM
	dev-perl/HTML-Tree"
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.96
	)"

SRC_TEST="do"
