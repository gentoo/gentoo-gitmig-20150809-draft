# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-chora/horde-chora-2.0.2.ebuild,v 1.3 2007/07/12 14:26:04 gustavoz Exp $

HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Chora is the Horde CVS viewer"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc sparc ~x86"

DEPEND=""
RDEPEND=">=www-apps/horde-3
	>=app-text/rcs-5.7-r1
	>=dev-util/cvs-1.11.2"
