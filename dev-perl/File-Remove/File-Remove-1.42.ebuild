# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Remove/File-Remove-1.42.ebuild,v 1.1 2008/07/24 11:55:09 tove Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Remove files and directories"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-File-Spec-0.84
	dev-lang/perl"

SRC_TEST="do"
