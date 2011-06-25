# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Inter/Test-Inter-1.20.0.ebuild,v 1.1 2011/06/25 08:19:01 tove Exp $

EAPI=4

MODULE_AUTHOR=SBECK
MODULE_VERSION=1.02
inherit perl-module

DESCRIPTION="Framework for more readable interactive test scripts"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
