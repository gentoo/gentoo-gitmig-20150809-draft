# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n-zh_TW/kde-i18n-zh_TW-2.2.2.ebuild,v 1.1 2003/03/09 00:08:27 hannes Exp $

inherit kde-i18n

MY_PN="${PN}.Big5"
SRC_URI="mirror://kde/${PV}/src/${MY_PN}-${PV}.tar.bz2"
S="${WORKDIR}/${MY_PN}"
