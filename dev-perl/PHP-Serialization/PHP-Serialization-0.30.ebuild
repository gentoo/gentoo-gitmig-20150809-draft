# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PHP-Serialization/PHP-Serialization-0.30.ebuild,v 1.2 2009/01/17 22:28:16 robbat2 Exp $

MODULE_AUTHOR=BOBTFISH
inherit perl-module

DESCRIPTION="convert PHP's serialize() into the equivalent Perl structure, and vice versa."

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST=do

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
