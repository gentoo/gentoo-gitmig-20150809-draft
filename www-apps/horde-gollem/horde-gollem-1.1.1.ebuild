# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-gollem/horde-gollem-1.1.1.ebuild,v 1.2 2010/08/19 13:43:16 hwoarang Exp $

HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Horde Gollem provides a web-based File Manager"

KEYWORDS="~alpha amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND="|| ( >=www-apps/horde-3 >=www-apps/horde-groupware-1 >=www-apps/horde-webmail-1 )"
