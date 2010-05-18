# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Readme/Pod-Readme-0.09.ebuild,v 1.2 2010/05/18 06:52:14 tove Exp $

EAPI=2

MODULE_AUTHOR=RRWO
inherit perl-module

DESCRIPTION="Convert POD to README file"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/regexp-common"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
#	test? ( virtual/perl-Test-Simple
#		dev-perl/Test-Pod
#		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
