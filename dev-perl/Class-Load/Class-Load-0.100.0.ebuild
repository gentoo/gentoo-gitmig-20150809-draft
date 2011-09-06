# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Load/Class-Load-0.100.0.ebuild,v 1.1 2011/09/06 15:36:49 tove Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="a working (require q{Class::Name}) and more "

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Scalar-List-Utils
	dev-perl/Data-OptList
	>=dev-perl/Package-Stash-0.320.0
	dev-perl/Try-Tiny
"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Fatal
	)"

SRC_TEST="do"
