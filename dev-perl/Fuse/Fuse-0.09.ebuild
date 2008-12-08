# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Fuse/Fuse-0.09.ebuild,v 1.1 2008/12/08 01:54:52 robbat2 Exp $

MODULE_AUTHOR=DPAVLIN
inherit perl-module

DESCRIPTION="Fuse module for perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/fuse
	dev-lang/perl"

# Test is whack - ChrisWhite
#SRC_TEST="do"
