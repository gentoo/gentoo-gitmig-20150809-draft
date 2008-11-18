# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-BaseDir/File-BaseDir-0.03.ebuild,v 1.4 2008/11/18 14:54:23 tove Exp $

MODULE_AUTHOR=PARDUS

inherit perl-module

DESCRIPTION="The Perl File-BaseDir Module"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~hppa ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
