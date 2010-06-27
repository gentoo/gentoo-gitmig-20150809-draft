# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bit-Vector/Bit-Vector-7.1.ebuild,v 1.8 2010/06/27 18:59:56 nixnut Exp $

EAPI=2

MODULE_AUTHOR=STBEY
inherit perl-module

DESCRIPTION="Efficient bit vector, set of integers and big int math library"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-perl/Carp-Clan
	>=virtual/perl-Storable-2.20"
DEPEND="${RDEPEND}"

SRC_TEST="do"
