# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-chora/horde-chora-1.2.3.ebuild,v 1.1 2005/04/26 02:54:11 vapier Exp $

inherit horde

DESCRIPTION="Chora is the Horde CVS viewer"

KEYWORDS="alpha amd64 hppa ppc sparc x86"

DEPEND=""
RDEPEND=">=www-apps/horde-2.2.8
	>=app-text/rcs-5.7-r1
	>=dev-util/cvs-1.11.2"
