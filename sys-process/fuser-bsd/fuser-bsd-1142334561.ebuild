# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/fuser-bsd/fuser-bsd-1142334561.ebuild,v 1.3 2006/09/12 21:04:43 uberlord Exp $

inherit base bsdmk eutils

MY_P="${PN/-bsd/}-${PV}"

DESCRIPTION="fuser(1) utility for *BSD"
HOMEPAGE="http://mbsd.msk.ru/stas/fuser.html"
SRC_URI="http://mbsd.msk.ru/dist/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="!sys-process/psmisc"

S="${WORKDIR}/${PN/-bsd/}"

src_install() {
	into /
	dosbin fuser

	doman fuser.1
}

