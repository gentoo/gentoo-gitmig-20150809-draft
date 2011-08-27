# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cache-mmap/cache-mmap-0.110.0.ebuild,v 1.1 2011/08/27 20:36:55 tove Exp $

EAPI=4

MY_PN=Cache-Mmap
MODULE_AUTHOR=PMH
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Shared data cache using memory mapped files"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="virtual/perl-Storable
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
