# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-hnd-vi-de/stardict-hnd-vi-de-20050917.ebuild,v 1.1 2005/12/03 11:40:02 pclouds Exp $

FROM_LANG="Vietnamese"
TO_LANG="German"

inherit stardict

HOMEPAGE="http://forum.vnoss.org/viewtopic.php?id=1818"
SRC_URI="http://james.dyndns.ws/pub/Dictionary/StarDict-James/VietDuc12K.zip"

KEYWORDS="~x86"
IUSE=""
S="${WORKDIR}/VietDuc"

RDEPEND=">=app-dicts/stardict-2.4.2"
