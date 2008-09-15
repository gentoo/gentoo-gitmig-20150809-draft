# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Jcode/Jcode-2.07.ebuild,v 1.1 2008/09/15 08:42:56 tove Exp $

MODULE_AUTHOR=DANKOGAI
inherit perl-module

DESCRIPTION="Japanese transcoding module for Perl"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-MIME-Base64-2.1
	dev-lang/perl"

SRC_TEST="do"
