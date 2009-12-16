# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/PodParser/PodParser-1.38.ebuild,v 1.8 2009/12/16 21:55:35 abcd Exp $

MODULE_AUTHOR=MAREKR
MY_PN=Pod-Parser
MY_P=${MY_PN}-${PV}

inherit perl-module

DESCRIPTION="Base class for creating POD filters and translators"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${MY_P}

SRC_TEST="do"
