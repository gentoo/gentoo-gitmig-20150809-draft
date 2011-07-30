# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Coverage/Pod-Coverage-0.21.ebuild,v 1.10 2011/07/30 10:41:27 tove Exp $

EAPI=3

MODULE_AUTHOR=RCLAMP
inherit perl-module

DESCRIPTION="Checks if the documentation of a module is comprehensive"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=virtual/perl-PodParser-1.13
	>=dev-perl/Devel-Symdump-2.01"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.35
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
