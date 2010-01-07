# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableContentParser/HTML-TableContentParser-0.13.ebuild,v 1.6 2010/01/07 14:12:41 tove Exp $

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
PATCHES=( "${FILESDIR}"/0.13-test.patch )
