# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-DesktopEntry/File-DesktopEntry-0.04.ebuild,v 1.11 2010/07/14 15:41:48 jer Exp $

EAPI=3

MODULE_AUTHOR=PARDUS
MODULE_SECTION=${PN}

inherit perl-module

DESCRIPTION="Object to handle .desktop files"

SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc ~ppc64 sparc x86"
IUSE="test"

RDEPEND="virtual/perl-File-Spec
	>=dev-perl/File-BaseDir-0.03"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
