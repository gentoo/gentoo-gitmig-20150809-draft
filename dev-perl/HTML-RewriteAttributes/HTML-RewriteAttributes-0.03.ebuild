# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-RewriteAttributes/HTML-RewriteAttributes-0.03.ebuild,v 1.1 2008/09/08 09:24:31 tove Exp $

MODULE_AUTHOR="SARTAK"
inherit perl-module

DESCRIPTION="Perl module for concise attribute rewriting"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/URI
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser"

SRC_TEST="do"
