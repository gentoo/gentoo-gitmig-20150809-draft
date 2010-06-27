# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Graph/Graph-0.94.ebuild,v 1.4 2010/06/27 19:11:05 nixnut Exp $

EAPI=2

MODULE_AUTHOR=JHI
inherit perl-module

DESCRIPTION="Data structure and ops for directed graphs"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="virtual/perl-Scalar-List-Utils
	>=virtual/perl-Storable-2.05"
DEPEND="${RDEPEND}"

SRC_TEST="do"
