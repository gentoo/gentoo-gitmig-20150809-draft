# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-BaseDir/File-BaseDir-0.03.ebuild,v 1.2 2008/05/17 06:36:34 tove Exp $

MODULE_AUTHOR=PARDUS

inherit perl-module

DESCRIPTION="The Perl File-BaseDir Module"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	dev-perl/module-build"

SRC_TEST=do
