# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-kronolith/horde-kronolith-2.1.4.ebuild,v 1.6 2006/12/11 22:53:17 kloeri Exp $

HORDE_PHP_FEATURES="-o mysql mysqli odbc postgres ldap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Kronolith is the Horde calendar application"

KEYWORDS="alpha ~amd64 hppa ppc sparc x86"

DEPEND=""
RDEPEND=">=www-apps/horde-3"
