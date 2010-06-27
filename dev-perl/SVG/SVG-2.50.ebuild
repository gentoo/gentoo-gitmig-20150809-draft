# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVG/SVG-2.50.ebuild,v 1.4 2010/06/27 19:19:44 nixnut Exp $

EAPI=2

MODULE_AUTHOR=RONAN
inherit perl-module

DESCRIPTION="Perl extension for generating Scalable Vector Graphics (SVG) documents"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
