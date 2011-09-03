# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Bzip2/Compress-Bzip2-2.90.0.ebuild,v 1.2 2011/09/03 21:05:03 tove Exp $

EAPI=4

MODULE_VERSION=2.09
MODULE_AUTHOR=ARJAY
inherit perl-module

DESCRIPTION="A Bzip2 perl module"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~mips sparc x86"
IUSE=""

RDEPEND="app-arch/bzip2"
DEPEND="${RDEPEND}"

SRC_TEST="do"
