# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-hnd-en-vi/stardict-hnd-en-vi-20050917.ebuild,v 1.2 2006/03/19 18:54:13 halcy0n Exp $

FROM_LANG="English"
TO_LANG="Vietnamese"

inherit stardict

HOMEPAGE="http://forum.vnoss.org/viewtopic.php?id=1818"
SRC_URI="http://james.dyndns.ws/pub/Dictionary/StarDict-James/AnhViet109K.zip"

KEYWORDS="~x86"
IUSE=""
S="${WORKDIR}/AnhViet"

DEPEND="${DEPEND}
	app-arch/unzip"

RDEPEND=">=app-dicts/stardict-2.4.2"
