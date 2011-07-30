# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Pod-Escapes/Pod-Escapes-1.40.0.ebuild,v 1.2 2011/07/30 12:22:12 tove Exp $

EAPI=2

MODULE_AUTHOR=SBURKE
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="for resolving Pod E<...> sequences"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"
