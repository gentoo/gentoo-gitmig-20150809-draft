# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n/kde-i18n-3.0.5a.ebuild,v 1.1 2002/12/22 14:01:00 hannes Exp $

inherit kde-i18n
S=${WORKDIR}/${PN}-${PV/a/}

PATCHES="${FILESDIR}/${P}-gentoo.diff"
