# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-mnemo/horde-mnemo-1.1.2.ebuild,v 1.1 2004/08/08 06:40:20 vapier Exp $

HORDE_PHP_FEATURES="mysql odbc postgres ldap"
inherit horde

DESCRIPTION="Mnemo is the Horde note manager"

KEYWORDS="x86 ppc sparc alpha hppa amd64"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.5"
