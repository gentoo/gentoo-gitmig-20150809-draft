# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-RewriteAttributes/HTML-RewriteAttributes-0.04.ebuild,v 1.1 2010/11/22 17:06:47 tove Exp $

EAPI=3

MODULE_AUTHOR="SARTAK"
inherit perl-module

DESCRIPTION="Perl module for concise attribute rewriting"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/URI
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST="do"
