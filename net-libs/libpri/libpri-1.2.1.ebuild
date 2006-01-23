# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpri/libpri-1.2.1.ebuild,v 1.2 2006/01/23 15:16:43 stkn Exp $

inherit eutils

## TODO:
#
# - bristuff (waiting for next upstream release...)
#

IUSE="bri"

MY_P="${P/_/-}"

BRI_VERSION="0.3.0-PRE-1c"

DESCRIPTION="Primary Rate ISDN (PRI) library"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://ftp.digium.com/pub/libpri/old/${MY_P}.tar.gz
	bri? ( http://www.netdomination.org/pub/asterisk/libpri-${PV}-bristuff-${BRI_VERSION}.diff.gz )"
#	bri? ( http://www.junghanns.net/downloads/bristuff-${BRI_VERSION}.tar.gz )"

RESTRICT="nomirror"

S="${WORKDIR}/${MY_P}"

S_BRI="${WORKDIR}/bristuff-${BRI_VERSION}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2.0-gentoo.diff

	if use bri; then
		einfo "Patching libpri w/ BRI stuff (${BRI_VERSION})"

		# fix a small clash in patches
		sed -i -e "s:CFLAGS=:CFLAGS+=:" \
			${WORKDIR}/libpri-${PV}-bristuff-${BRI_VERSION}.diff
#			${S_BRI}/patches/libpri.patch

#		epatch ${S_BRI}/patches/libpri.patch
		epatch ${WORKDIR}/libpri-${PV}-bristuff-${BRI_VERSION}.diff
	fi
}

src_compile() {
	emake || die
}

src_install() {
	make INSTALL_PREFIX=${D} install || die

	dodoc ChangeLog README TODO LICENSE
}
