# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n/kde-i18n-3.0.5a.ebuild,v 1.2 2003/02/13 08:02:45 vapier Exp $

inherit kde-i18n
S=${WORKDIR}/${PN}-${PV/a/}

PATCHES="${FILESDIR}/${P}-gentoo.diff"
