# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableExtract/HTML-TableExtract-2.10.ebuild,v 1.10 2008/09/30 13:47:28 tove Exp $

MODULE_AUTHOR=MSISK
inherit perl-module

DESCRIPTION="The Perl Table-Extract Module"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

mydoc="TODO"

DEPEND=">=dev-perl/HTML-Element-Extended-1.16
	dev-perl/HTML-Parser
	dev-lang/perl"
