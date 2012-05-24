# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Uniqid/Data-Uniqid-0.12.ebuild,v 1.2 2012/05/24 05:36:27 flameeyes Exp $

EAPI="4"

MODULE_AUTHOR="MWX"

inherit perl-module

DESCRIPTION="Perl extension for simple genrating of unique id's"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/perl
	virtual/perl-Math-BigInt
	virtual/perl-Time-HiRes"
DEPEND="${RDEPEND}"

SRC_TEST="do"
