# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Load/Class-Load-0.06.ebuild,v 1.1 2010/11/22 17:16:11 tove Exp $

EAPI=3

MODULE_AUTHOR=SARTAK
inherit perl-module

DESCRIPTION="a working (require q{Class::Name}) and more "

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Fatal
	)"

SRC_TEST="do"
