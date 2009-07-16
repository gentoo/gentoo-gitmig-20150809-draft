# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.40.ebuild,v 1.1 2009/07/16 05:05:11 tove Exp $

EAPI=2

MODULE_AUTHOR=PETDANCE
inherit perl-module

DESCRIPTION="check for POD errors in files"

LICENSE="|| ( Artistic-2 GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/perl-Pod-Simple-3.07
	>=virtual/perl-Test-Simple-0.62"
DEPEND="${RDEPEND}"

SRC_TEST="do"
