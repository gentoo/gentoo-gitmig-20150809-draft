# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-PersistentObjectDatabaseSchemaTiein/ezc-PersistentObjectDatabaseSchemaTiein-1.0.ebuild,v 1.2 2006/07/12 07:53:58 sebastian Exp $

inherit php-ezc

DESCRIPTION="This eZ component allows the automatic generation of PersistentObject definition files from DatabaseSchema definitions."
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="${RDEPEND}
	>=dev-php5/ezc-PersistentObject-1.0.1
	dev-php5/ezc-DatabaseSchema
	>=dev-php5/ezc-ConsoleTools-1.1"
