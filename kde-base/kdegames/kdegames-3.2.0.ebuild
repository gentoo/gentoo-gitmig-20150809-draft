# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.2.0.ebuild,v 1.4 2004/02/05 16:41:13 lu_zero Exp $
inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"
IUSE=""
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

src_unpack()
{
	kde_src_unpack
	epatch ${FILESDIR}/ktron.patch
	epatch ${FILESDIR}/libksirtet.patch
}
