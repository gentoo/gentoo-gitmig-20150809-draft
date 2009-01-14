# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-StrictConstructor/MooseX-StrictConstructor-0.07.ebuild,v 1.1 2009/01/14 11:24:17 tove Exp $

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="Make your object constructors blow up on unknown attributes"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-perl/Moose-0.56"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
