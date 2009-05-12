# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Stag/Data-Stag-0.11.ebuild,v 1.3 2009/05/12 19:40:28 tove Exp $

EAPI=2

MODULE_AUTHOR=CMUNGALL
inherit perl-module

DESCRIPTION="Structured Tags datastructures"
HOMEPAGE="http://stag.sourceforge.net/"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-perl/IO-String"
DEPEND="${RDEPEND}"

SRC_TEST="do"
