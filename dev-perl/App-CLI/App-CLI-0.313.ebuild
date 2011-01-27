# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/App-CLI/App-CLI-0.313.ebuild,v 1.1 2011/01/27 02:47:00 robbat2 Exp $

MODULE_AUTHOR=CORNELIUS
inherit perl-module

DESCRIPTION="Dispatcher module for command line interface programs"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="dev-lang/perl
	>=virtual/perl-Getopt-Long-2.35
	virtual/perl-Locale-Maketext-Simple
	virtual/perl-Pod-Simple"
DEPEND="${RDEPEND}"

SRC_TEST="do"
