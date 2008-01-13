# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-TreeDatabaseTiein/ezc-TreeDatabaseTiein-1.0.ebuild,v 1.2 2008/01/13 16:29:13 jokey Exp $

EZC_BASE_MIN="1.4"
inherit php-ezc

DESCRIPTION="This eZ component implements the database related backends and data stores for the Tree component."
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-Database-1.3
	>=dev-php5/ezc-Tree-1.0"
