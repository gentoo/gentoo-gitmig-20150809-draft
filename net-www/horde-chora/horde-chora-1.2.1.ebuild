# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-chora/horde-chora-1.2.1.ebuild,v 1.2 2004/03/28 17:35:37 zx Exp $

inherit horde

DESCRIPTION="Chora is the Horde CVS viewer"

KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.4
	>=app-text/rcs-5.7-r1
	>=dev-util/cvs-1.11.2"
