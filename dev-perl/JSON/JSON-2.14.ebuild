# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON/JSON-2.14.ebuild,v 1.1 2009/02/25 20:43:57 tove Exp $

MODULE_AUTHOR=MAKAMAKA
inherit perl-module

DESCRIPTION="parse and convert to JSON (JavaScript Object Notation)"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
