# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic/Perl-Critic-1.106.ebuild,v 1.4 2012/03/24 19:53:33 armin76 Exp $

EAPI=3

#inherit versionator
MODULE_AUTHOR=ELLIOTJS
#MY_P="${PN}-$(delete_version_separator 2)"
inherit perl-module

#S=${WORKDIR}/${MY_P}

DESCRIPTION="Critique Perl source code for best-practices"

SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="test"

RDEPEND=">=virtual/perl-Module-Pluggable-3.1
	>=dev-perl/Config-Tiny-2
	dev-perl/List-MoreUtils
	dev-perl/IO-String
	dev-perl/String-Format
	dev-perl/perltidy
	>=dev-perl/PPI-1.205
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
