# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-turba/horde-turba-2.0.3.ebuild,v 1.1 2005/08/07 21:58:10 vapier Exp $

HORDE_PHP_FEATURES="-o mysql odbc postgres ldap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Turba is the Horde address book / contact management program"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND=">=www-apps/horde-3"
