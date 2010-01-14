# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.40.ebuild,v 1.2 2010/01/14 14:52:56 grobian Exp $

EAPI=2

MODULE_AUTHOR=PETDANCE
inherit perl-module

DESCRIPTION="check for POD errors in files"

LICENSE="|| ( Artistic-2 GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=virtual/perl-Pod-Simple-3.07
	>=virtual/perl-Test-Simple-0.62"
DEPEND="${RDEPEND}"

SRC_TEST="do"
