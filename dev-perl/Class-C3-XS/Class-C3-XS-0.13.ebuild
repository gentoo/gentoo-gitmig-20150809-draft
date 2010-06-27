# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-C3-XS/Class-C3-XS-0.13.ebuild,v 1.6 2010/06/27 17:51:32 nixnut Exp $

EAPI=2

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="XS speedups for Class::C3"

SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86 ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
