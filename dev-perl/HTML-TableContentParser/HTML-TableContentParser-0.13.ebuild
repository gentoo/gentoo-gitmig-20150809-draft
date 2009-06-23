# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableContentParser/HTML-TableContentParser-0.13.ebuild,v 1.5 2009/06/23 10:53:41 tove Exp $

EAPI=2

MODULE_AUTHOR=SDRABBLE
inherit perl-module

DESCRIPTION="Parse the content of tables in HTML"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-perl/HTML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST=do
