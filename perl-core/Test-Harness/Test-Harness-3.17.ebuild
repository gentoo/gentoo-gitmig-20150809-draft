# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test-Harness/Test-Harness-3.17.ebuild,v 1.1 2009/05/06 08:16:13 tove Exp $

MODULE_AUTHOR=ANDYA
inherit perl-module

DESCRIPTION="Runs perl standard test scripts with statistics"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"

PREFER_BUILDPL=no
SRC_TEST="do"
mydoc="rfc*.txt"
