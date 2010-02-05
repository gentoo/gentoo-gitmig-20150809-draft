# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DB_File-Lock/DB_File-Lock-0.05.ebuild,v 1.2 2010/02/05 17:24:07 tove Exp $

EAPI=2

MODULE_AUTHOR=DHARRIS

inherit perl-module

DESCRIPTION="Locking with flock wrapper for DB_File"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-DB_File"
DEPEND="${RDEPEND}"

SRC_TEST=do
