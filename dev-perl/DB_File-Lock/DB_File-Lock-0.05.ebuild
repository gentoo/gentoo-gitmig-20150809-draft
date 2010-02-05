# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DB_File-Lock/DB_File-Lock-0.05.ebuild,v 1.1 2010/02/05 16:24:36 weaver Exp $

EAPI=2

MODULE_AUTHOR=DHARRIS

inherit perl-module

DESCRIPTION="Locking with flock wrapper for DB_File"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="perl-core/DB_File"
RDEPEND="${DEPEND}"
