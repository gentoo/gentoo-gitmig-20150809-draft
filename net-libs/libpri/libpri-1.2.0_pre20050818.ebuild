# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpri/libpri-1.2.0_pre20050818.ebuild,v 1.1 2005/08/19 19:00:02 stkn Exp $

inherit eutils

## TODO:
#
# - bristuff (waiting for next upstream release...)
#

IUSE=""

#BRI_VERSION="0.2.0-RC8h"

DESCRIPTION="Primary Rate ISDN (PRI) library"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://www.netdomination.org/pub/asterisk/${P}.tar.bz2"
#	 bri? ( http://www.junghanns.net/asterisk/downloads/bristuff-${BRI_VERSION}.tar.gz )"

S="${WORKDIR}/${PN}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

#	if use bri; then
#		einfo "Patching libpri w/ BRI stuff (${BRI_VERSION})"
#		epatch ${WORKDIR}/bristuff-${BRI_VERSION}/patches/libpri.patch
#	fi
}

src_compile() {
	emake || die
}

src_install() {
	make INSTALL_PREFIX=${D} install || die

	dodoc ChangeLog README TODO LICENSE
}
