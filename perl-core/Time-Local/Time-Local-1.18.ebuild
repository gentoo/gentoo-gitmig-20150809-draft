# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Time-Local/Time-Local-1.18.ebuild,v 1.5 2009/12/16 22:00:10 abcd Exp $

MODULE_AUTHOR=DROLSKY

inherit perl-module

DESCRIPTION="Implements timelocal() and timegm()"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
