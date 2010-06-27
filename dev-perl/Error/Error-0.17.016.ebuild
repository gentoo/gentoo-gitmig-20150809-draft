# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Error/Error-0.17.016.ebuild,v 1.8 2010/06/27 19:09:04 nixnut Exp $

EAPI=2

inherit versionator
MODULE_AUTHOR=SHLOMIF
MY_PV="$(delete_version_separator 2)"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Error/exception handling in an OO-ish way"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( >=dev-perl/Test-Pod-1.14
		>=dev-perl/Test-Pod-Coverage-1.04 )"

SRC_TEST="do"
