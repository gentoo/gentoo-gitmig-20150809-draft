# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Set-IntSpan/Set-IntSpan-1.13.ebuild,v 1.1 2008/08/02 18:57:11 tove Exp $

MODULE_AUTHOR=SWMCD
inherit perl-module

DESCRIPTION="Manages sets of integers"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
