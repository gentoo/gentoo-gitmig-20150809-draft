# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n-fr/kde-i18n-fr-3.1-r1.ebuild,v 1.3 2003/02/28 21:56:53 vapier Exp $

inherit eutils kde-i18n

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}
