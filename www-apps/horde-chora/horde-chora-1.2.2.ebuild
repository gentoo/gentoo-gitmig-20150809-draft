# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-chora/horde-chora-1.2.2.ebuild,v 1.1 2004/08/15 10:09:42 stuart Exp $

inherit horde

DESCRIPTION="Chora is the Horde CVS viewer"

KEYWORDS="x86 ppc sparc alpha hppa amd64"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.4
	>=app-text/rcs-5.7-r1
	>=dev-util/cvs-1.11.2"
