# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/amule/amule-1.0.9.ebuild,v 1.4 2003/10/18 23:18:13 scandium Exp $

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}

DESCRIPTION="aNOTHER wxWindows based eMule P2P Client"
HOMEPAGE="http://sourceforge.net/projects/amule"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=x11-libs/wxGTK-2.4.1
	>=sys-libs/zlib-1.1.4"

pkg_setup() {
	# FIXME: Is this really how we want to do this ?
	GREP=`grep ' unicode' /var/db/pkg/x11-libs/wxGTK*/USE`
	if [ "${GREP}" != "" ]; then
		eerror "This package doesn't work with wxGTK"
		eerror "compiled with gtk2 and unicode in USE"
		eerror "Please re-compile wxGTK with -unicode"
		die "aborting..."
	fi
}

src_compile () {
	econf || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die
}

src_install () {
	einstall || die
}
