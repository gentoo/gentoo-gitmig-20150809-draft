# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-mnemo/horde-mnemo-1.1.1.ebuild,v 1.2 2004/08/15 16:31:16 stuart Exp $

HORDE_PHP_FEATURES="mysql odbc postgres ldap"
inherit horde

DESCRIPTION="Mnemo is the Horde note manager"

KEYWORDS="x86 ppc sparc alpha hppa amd64"

DEPEND=""
RDEPEND=">=www-apps/horde-2.2.5"
