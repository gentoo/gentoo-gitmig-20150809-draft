# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-mnemo/horde-mnemo-2.1.2.ebuild,v 1.4 2008/03/18 19:27:04 armin76 Exp $

HORDE_PHP_FEATURES="-o mysql mysqli odbc postgres ldap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Mnemo is the Horde note manager"

KEYWORDS="alpha ~amd64 hppa ppc sparc x86"

DEPEND=""
RDEPEND=">=www-apps/horde-3"
