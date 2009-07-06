# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-BaseDir/File-BaseDir-0.03.ebuild,v 1.5 2009/07/06 20:49:34 jer Exp $

MODULE_AUTHOR=PARDUS

inherit perl-module

DESCRIPTION="The Perl File-BaseDir Module"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 hppa ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
