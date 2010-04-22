# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.43.ebuild,v 1.1 2010/04/22 05:47:24 tove Exp $

EAPI=2

MODULE_AUTHOR=DWHEELER
inherit perl-module

DESCRIPTION="check for POD errors in files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=virtual/perl-Pod-Simple-3.05
	>=virtual/perl-Test-Simple-0.62"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.30"

SRC_TEST="do"
