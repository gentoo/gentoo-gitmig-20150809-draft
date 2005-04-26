# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-kronolith/horde-kronolith-1.1.4.ebuild,v 1.1 2005/04/26 02:54:08 vapier Exp $

HORDE_PHP_FEATURES="-o mysql odbc postgres ldap"
inherit horde

DESCRIPTION="Kronolith is the Horde calendar application"

KEYWORDS="alpha amd64 hppa ppc sparc x86"

DEPEND=""
RDEPEND=">=www-apps/horde-2.2.8"
