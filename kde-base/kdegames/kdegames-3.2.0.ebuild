# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.2.0.ebuild,v 1.13 2004/07/14 16:04:11 agriffis Exp $

inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"

KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"
IUSE=""

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/ktron.patch
	epatch ${FILESDIR}/libksirtet.patch
}
