# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-chora/horde-chora-2.0.1.ebuild,v 1.8 2010/03/05 07:34:56 ulm Exp $

HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Chora is the Horde CVS viewer"

KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND=">=www-apps/horde-3
	>=dev-vcs/rcs-5.7-r1
	>=dev-util/cvs-1.11.2"
