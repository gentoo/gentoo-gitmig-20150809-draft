# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic/Perl-Critic-1.113.ebuild,v 1.1 2011/02/18 07:15:12 tove Exp $

EAPI=3

MODULE_AUTHOR=ELLIOTJS
MODULE_VERSION=1.113
inherit perl-module

DESCRIPTION="Critique Perl source code for best-practices"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=virtual/perl-Module-Pluggable-3.1
	>=dev-perl/Config-Tiny-2
	>=dev-perl/Email-Address-1.88.9
	dev-perl/List-MoreUtils
	dev-perl/IO-String
	dev-perl/perltidy
	>=dev-perl/PPI-1.208
	dev-perl/PPIx-Utilities
	dev-perl/PPIx-Regexp
	dev-perl/Pod-Spell
	>=dev-perl/set-scalar-1.20
	dev-perl/File-Which
	dev-perl/B-Keywords
	dev-perl/Readonly
	dev-perl/Exception-Class
	dev-perl/String-Format
	>=virtual/perl-version-0.77"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Deep
		dev-perl/PadWalker
		dev-perl/Test-Memory-Cycle
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

mydoc="extras/* examples/*"

SRC_TEST="do"
