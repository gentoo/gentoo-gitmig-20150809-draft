# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Package-Constants/Package-Constants-0.01.ebuild,v 1.6 2008/10/23 11:33:26 armin76 Exp $

MODULE_AUTHOR=KANE
inherit perl-module

DESCRIPTION="List all constants declared in a package"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc64 sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST=do
