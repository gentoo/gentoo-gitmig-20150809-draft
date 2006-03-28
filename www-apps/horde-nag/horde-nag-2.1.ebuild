# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-nag/horde-nag-2.1.ebuild,v 1.4 2006/03/28 02:33:39 halcy0n Exp $

HORDE_PHP_FEATURES="-o mysql mysqli odbc postgres ldap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Nag is the Horde multiuser task list manager"

KEYWORDS="~alpha ~amd64 ~hppa ppc sparc x86"

DEPEND=""
RDEPEND=">=www-apps/horde-3"
