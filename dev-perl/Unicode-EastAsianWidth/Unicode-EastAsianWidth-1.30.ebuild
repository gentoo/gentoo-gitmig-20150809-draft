# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-EastAsianWidth/Unicode-EastAsianWidth-1.30.ebuild,v 1.2 2012/03/21 20:39:25 jer Exp $

EAPI=4

MODULE_AUTHOR="AUDREYT"
inherit perl-module

DESCRIPTION="East Asian Width properties"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="virtual/perl-File-Spec"
DEPEND="${RDEPEND}
	dev-perl/Module-Install
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-Module-Build"

SRC_TEST="do"
