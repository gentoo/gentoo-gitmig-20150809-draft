# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gemsvnc/gemsvnc-1.ebuild,v 1.2 2004/01/02 02:37:53 vapier Exp $

inherit gcc flag-o-matic

DESCRIPTION="an X11 vnc server for remote control"
HOMEPAGE="http://www.elilabs.com/~rj/gemsvnc/"
#SRC_URI="http://www.elilabs.com/~rj/gemsvnc/${PN}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=net-libs/libvncserver-0.6
	virtual/x11
	sys-libs/zlib
	media-libs/jpeg"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:Bool:rfbBool:g' \
		-e 's:CARD8:uint8_t:g' \
		-e 's:CARD16:uint16_t:g' \
		-e 's:RFBKeySym:rfbKeySym:g' \
		-e 's:XGetKeyboardMapping:(rfbKeySym*)XGetKeyboardMapping:' \
		gemsvnc.c
}

src_compile() {
	append-flags -I/usr/include/rfb
	emake || die "emake failed"
}

src_install() {
	dobin gemsvnc || die
	dodoc CHANGES README TODO
}
