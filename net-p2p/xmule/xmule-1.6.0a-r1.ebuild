# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/xmule/xmule-1.6.0a-r1.ebuild,v 1.8 2004/03/01 06:26:59 eradicator Exp $

inherit eutils

MY_P=${P//a}
S=${WORKDIR}/${MY_P}

DESCRIPTION="wxWindows based client for the eDonkey/eMule/lMule network"
HOMEPAGE="http://www.xmule.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND=">=x11-libs/wxGTK-2.4
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

src_unpack() {
# Small patch to fix rehashing of unfinished files

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/rehash.patch
}

src_compile () {
	econf || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die
}

src_install () {
	einstall || die
}
