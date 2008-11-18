# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Path-Expand/File-Path-Expand-1.02.ebuild,v 1.8 2008/11/18 14:58:30 tove Exp $

MODULE_AUTHOR=RCLAMP
inherit perl-module

DESCRIPTION="Expand filenames"

LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"
SLOT="0"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
