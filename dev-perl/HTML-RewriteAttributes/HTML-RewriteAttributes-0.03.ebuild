# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-RewriteAttributes/HTML-RewriteAttributes-0.03.ebuild,v 1.2 2009/03/01 15:46:02 patrick Exp $

MODULE_AUTHOR="SARTAK"
inherit perl-module

DESCRIPTION="Perl module for concise attribute rewriting"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/URI
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser"
RDEPEND="${DEPEND}"

SRC_TEST="do"
