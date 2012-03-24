# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Abstract/Email-Abstract-3.001.ebuild,v 1.3 2012/03/24 20:07:35 armin76 Exp $

inherit versionator

MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=RJBS

inherit perl-module

DESCRIPTION="unified interface to mail representations"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE="test"

RDEPEND=">=virtual/perl-Class-ISA-0.20
	>=dev-perl/Email-Simple-1.91
	>=virtual/perl-Module-Pluggable-1.5
	virtual/perl-Scalar-List-Utils
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple
		>=dev-perl/Test-Pod-1.14
		>=dev-perl/Test-Pod-Coverage-1.08 )"

SRC_TEST="do"
