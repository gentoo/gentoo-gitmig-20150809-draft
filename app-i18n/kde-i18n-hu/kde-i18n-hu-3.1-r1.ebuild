# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n-hu/kde-i18n-hu-3.1-r1.ebuild,v 1.1 2003/01/30 17:30:01 hannes Exp $

inherit kde-i18n eutils

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}
