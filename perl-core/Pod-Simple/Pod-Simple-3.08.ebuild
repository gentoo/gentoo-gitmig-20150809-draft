# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Pod-Simple/Pod-Simple-3.08.ebuild,v 1.2 2009/12/16 21:55:57 abcd Exp $

EAPI=2

MODULE_AUTHOR=ARANDAL
inherit perl-module

DESCRIPTION="framework for parsing Pod"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND=">=virtual/perl-Pod-Escapes-1.04"
RDEPEND="${DEPEND}"

SRC_TEST="do"
