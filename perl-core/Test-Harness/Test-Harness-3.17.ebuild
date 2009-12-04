# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test-Harness/Test-Harness-3.17.ebuild,v 1.2 2009/12/04 12:34:21 fauli Exp $

MODULE_AUTHOR=ANDYA
inherit perl-module

DESCRIPTION="Runs perl standard test scripts with statistics"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"

PREFER_BUILDPL=no
SRC_TEST="do"
mydoc="rfc*.txt"
