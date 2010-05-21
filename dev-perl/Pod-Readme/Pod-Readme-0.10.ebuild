# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Readme/Pod-Readme-0.10.ebuild,v 1.1 2010/05/21 07:08:25 tove Exp $

EAPI=3

MODULE_AUTHOR=BIGPRESH
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
