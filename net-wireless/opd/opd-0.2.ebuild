# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/opd/opd-0.2.ebuild,v 1.2 2007/07/15 03:28:52 mr_bones_ Exp $

inherit eutils

MY_PV="v${PV}-2003-03-18"
DESCRIPTION="OBEX Push daemon for BlueZ and IrDA."
HOMEPAGE="http://oss.bdit.de/opd.html"
SRC_URI="http://oss.bdit.de/download/opd-${MY_PV}.tgz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	dev-libs/openobex
	net-wireless/bluez-libs"

S=${WORKDIR}

src_compile() {
	epatch ${FILESDIR}/${PV}-compile-fix.patch
	make || "compilation failed"
}

src_install() {
	dobin opd
}

pkg_postinst() {
	einfo "As there is no documentation included, please read the information on URL:"
	einfo "\t\t${HOMEPAGE}"
}
