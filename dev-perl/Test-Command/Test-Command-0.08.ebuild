# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Command/Test-Command-0.08.ebuild,v 1.7 2010/07/04 10:04:01 ssuominen Exp $

EAPI=2

MODULE_AUTHOR=DANBOO
inherit perl-module

DESCRIPTION="Test routines for external commands"

SLOT="0"
KEYWORDS="alpha amd64 ~ppc ppc64 sparc x86"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
