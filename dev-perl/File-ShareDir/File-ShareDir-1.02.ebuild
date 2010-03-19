# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ShareDir/File-ShareDir-1.02.ebuild,v 1.2 2010/03/19 22:15:34 tove Exp $

EAPI=2

MODULE_AUTHOR="ADAMK"
inherit perl-module

DESCRIPTION="Locate per-dist and per-module shared files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Class-Inspector"
DEPEND="${RDEPEND}"

SRC_TEST="do"
