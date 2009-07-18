# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/fuser-bsd/fuser-bsd-1142334561.ebuild,v 1.6 2009/07/18 09:43:26 aballier Exp $

inherit base bsdmk eutils

MY_P="${PN/-bsd/}-${PV}"

DESCRIPTION="fuser(1) utility for *BSD"
HOMEPAGE="http://mbsd.msk.ru/stas/fuser.html"
SRC_URI="http://mbsd.msk.ru/dist/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND="sys-freebsd/freebsd-mk-defs"
RDEPEND="!sys-process/psmisc"

S="${WORKDIR}/${PN/-bsd/}"

src_install() {
	into /
	dosbin fuser

	doman fuser.1
}
