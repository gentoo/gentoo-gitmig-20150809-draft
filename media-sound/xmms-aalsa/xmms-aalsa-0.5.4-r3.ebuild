# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-aalsa/xmms-aalsa-0.5.4-r3.ebuild,v 1.5 2002/08/01 11:40:16 seemant Exp $

MY_P=${PN}_${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="This output plugin allows xmms to work with alsa"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/aalsa/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-sound/xmms-1.2.5-r1 \
	=media-libs/alsa-lib-0.5*"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp -a configure configure.orig
	sed -e "s:-O2:${CFLAGS}:g" configure.orig > configure
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} libdir=/usr/lib/xmms/Output install || install
	dodoc AUTHORS COPYING NEWS README
}

