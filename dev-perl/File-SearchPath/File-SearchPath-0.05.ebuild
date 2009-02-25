# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-SearchPath/File-SearchPath-0.05.ebuild,v 1.1 2009/02/25 20:33:12 tove Exp $

MODULE_AUTHOR="TJENNESS"
inherit perl-module

DESCRIPTION="Search for a file in an environment variable path"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST=do
