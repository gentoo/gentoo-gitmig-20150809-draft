# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Perl-Critic/Test-Perl-Critic-1.20.0.ebuild,v 1.1 2011/08/28 13:42:19 tove Exp $

EAPI=4

MODULE_AUTHOR=THALJEF
MODULE_VERSION=1.02
inherit perl-module

DESCRIPTION="Use Perl::Critic in test programs"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Perl-Critic-1.105"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
