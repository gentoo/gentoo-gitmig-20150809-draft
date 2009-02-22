# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON/JSON-2.13.ebuild,v 1.1 2009/02/22 08:53:56 tove Exp $

MODULE_AUTHOR=MAKAMAKA
inherit perl-module

DESCRIPTION="parse and convert to JSON (JavaScript Object Notation)"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
