# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test-Simple/Test-Simple-0.80.ebuild,v 1.3 2008/07/15 18:39:49 armin76 Exp $

MODULE_AUTHOR=MSCHWERN

inherit perl-module

DESCRIPTION="Basic utilities for writing tests"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0-r12"

SRC_TEST="do"

mydoc="rfc*.txt"
myconf="INSTALLDIRS=vendor"
