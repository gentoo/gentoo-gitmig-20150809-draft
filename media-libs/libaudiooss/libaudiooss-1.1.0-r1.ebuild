# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libaudiooss/libaudiooss-1.1.0-r1.ebuild,v 1.6 2004/07/14 19:59:04 agriffis Exp $

HOMEPAGE="http://romeo.skybert.no/~erik/linux.html"
DESCRIPTION="Transparent OSS emulation on top of the Network Audio System"
SRC_URI="http://romeo.skybert.no/~erik/audiooss-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

DEPEND="virtual/x11
	media-libs/nas"

S=${WORKDIR}/audiooss-${PV}

src_compile() {
	xmkmf -a || die
	mv Makefile Makefile.old
	sed -e "s:.*CDEBUGFLAGS =.*:CDEBUGFLAGS=${CFLAGS}:" \
		Makefile.old > Makefile
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
}
