# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Classify/Params-Classify-0.13.0.ebuild,v 1.3 2011/11/06 17:23:47 maekke Exp $

EAPI=4

MODULE_AUTHOR=ZEFRAM
MODULE_VERSION=0.013
inherit perl-module

DESCRIPTION="Argument type classification"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE="test"

RDEPEND="
	>=virtual/perl-Scalar-List-Utils-1.10.0
	virtual/perl-XSLoader
	virtual/perl-parent
"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build
	>=virtual/perl-ExtUtils-CBuilder-0.150.0
	test? (
		virtual/perl-Test-Simple
	)
"

SRC_TEST="do"
