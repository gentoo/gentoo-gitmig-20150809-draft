# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-DesktopEntry/File-DesktopEntry-0.04.ebuild,v 1.6 2009/12/26 19:00:10 armin76 Exp $

MODULE_AUTHOR=PARDUS
MODULE_SECTION=${PN}

inherit perl-module

DESCRIPTION="Object to handle .desktop files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc x86"
IUSE="test"
SRC_TEST="do"

RDEPEND="dev-lang/perl
	virtual/perl-File-Spec
	>=dev-perl/File-BaseDir-0.03"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )"
