# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-nag/horde-nag-1.1.1.ebuild,v 1.4 2004/04/06 00:38:52 vapier Exp $

HORDE_PHP_FEATURES="mysql odbc postgres ldap"
inherit horde

DESCRIPTION="Nag is the Horde multiuser task list manager"

KEYWORDS="x86 ppc sparc alpha hppa"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.5"
