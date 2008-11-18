# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-DesktopEntry/File-DesktopEntry-0.04.ebuild,v 1.4 2008/11/18 14:55:11 tove Exp $

MODULE_AUTHOR=PARDUS
MODULE_SECTION=${PN}

inherit perl-module

DESCRIPTION="Object to handle .desktop files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="test"
SRC_TEST="do"

RDEPEND="dev-lang/perl
	virtual/perl-File-Spec
	>=dev-perl/File-BaseDir-0.03"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )"
