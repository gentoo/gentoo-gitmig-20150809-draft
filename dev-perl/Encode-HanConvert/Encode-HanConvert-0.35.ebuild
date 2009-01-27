# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-HanConvert/Encode-HanConvert-0.35.ebuild,v 1.1 2009/01/27 10:07:50 tove Exp $

MODULE_AUTHOR=AUDREYT
inherit perl-module

DESCRIPTION="Traditional and Simplified Chinese mappings"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
