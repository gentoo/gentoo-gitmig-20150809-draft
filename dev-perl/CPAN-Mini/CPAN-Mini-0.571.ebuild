# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Mini/CPAN-Mini-0.571.ebuild,v 1.3 2009/07/19 17:35:51 tove Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="create a minimal mirror of CPAN"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	>=virtual/perl-IO-Compress-1.20
	dev-perl/File-HomeDir
	dev-perl/URI
	dev-lang/perl"

SRC_TEST="do"
