# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON/JSON-2.12.ebuild,v 1.1 2008/09/07 10:21:01 tove Exp $

MODULE_AUTHOR=MAKAMAKA
inherit perl-module

DESCRIPTION="parse and convert to JSON (JavaScript Object Notation)"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
