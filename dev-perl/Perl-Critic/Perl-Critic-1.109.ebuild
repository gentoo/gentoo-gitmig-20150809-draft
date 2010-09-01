# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic/Perl-Critic-1.109.ebuild,v 1.1 2010/09/01 07:04:40 tove Exp $

EAPI=3

#inherit versionator
MODULE_AUTHOR=ELLIOTJS
#MY_P="${PN}-$(delete_version_separator 2)"
inherit perl-module

#S=${WORKDIR}/${MY_P}

DESCRIPTION="Critique Perl source code for best-practices"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~ppc-macos"
IUSE="test"

RDEPEND=">=virtual/perl-Module-Pluggable-3.1
	>=dev-perl/Config-Tiny-2
	>=dev-perl/Email-Address-1.88.9
	dev-perl/List-MoreUtils
	dev-perl/IO-String
	dev-perl/String-Format
	dev-perl/perltidy
	>=dev-perl/PPI-1.208
	dev-perl/PPIx-Utilities
	>=dev-perl/set-scalar-1.20
	dev-perl/File-Which
	dev-perl/B-Keywords
	dev-perl/Readonly
	dev-perl/Exception-Class
	virtual/perl-version"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Deep
		dev-perl/PadWalker
		dev-perl/Test-Memory-Cycle
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

mydoc="extras/* examples/*"

SRC_TEST="do"
