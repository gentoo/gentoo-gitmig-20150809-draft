# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

IUSE=""

S=${WORKDIR}/audiooss-${PV}
HOMEPAGE="http://romeo.skybert.no/~erik/linux.html"
DESCRIPTION="Transparent OSS emulation on top of the Network Audio System"
SRC_URI="http://romeo.skybert.no/~erik/audiooss-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/x11
	media-libs/nas"
RDEPEND="${DEPEND}"

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
