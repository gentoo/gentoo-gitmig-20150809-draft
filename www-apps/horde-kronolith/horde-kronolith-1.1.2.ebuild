# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-kronolith/horde-kronolith-1.1.2.ebuild,v 1.2 2004/08/15 16:30:01 stuart Exp $

HORDE_PHP_FEATURES="mysql odbc postgres ldap"
inherit horde

DESCRIPTION="Kronolith is the Horde calendar application"

KEYWORDS="x86 ppc sparc alpha hppa amd64"

DEPEND=""
RDEPEND=">=www-apps/horde-2.2.5"
