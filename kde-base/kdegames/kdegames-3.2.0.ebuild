# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.2.0.ebuild,v 1.10 2004/02/23 18:02:41 brad_mssw Exp $

inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"

KEYWORDS="x86 ppc sparc hppa amd64"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/ktron.patch
	epatch ${FILESDIR}/libksirtet.patch
}
