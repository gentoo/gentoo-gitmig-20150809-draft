# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-kronolith/horde-kronolith-1.1.2.ebuild,v 1.3 2004/04/06 00:37:48 vapier Exp $

HORDE_PHP_FEATURES="mysql odbc postgres ldap"
inherit horde

DESCRIPTION="Kronolith is the Horde calendar application"

KEYWORDS="x86 ppc sparc alpha hppa"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.5"
