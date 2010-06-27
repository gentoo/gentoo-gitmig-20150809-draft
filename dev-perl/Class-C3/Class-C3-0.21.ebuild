# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-C3/Class-C3-0.21.ebuild,v 1.7 2010/06/27 17:53:38 nixnut Exp $

EAPI=2

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="A pragma to use the C3 method resolution order algortihm"

SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86 ~x86-solaris"
IUSE="test"

RDEPEND="
	|| ( >=dev-lang/perl-5.10
		>=dev-perl/Class-C3-XS-0.07 )"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
