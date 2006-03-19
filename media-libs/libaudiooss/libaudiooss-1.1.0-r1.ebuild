# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libaudiooss/libaudiooss-1.1.0-r1.ebuild,v 1.7 2006/03/19 22:53:36 joshuabaergen Exp $

HOMEPAGE="http://romeo.skybert.no/~erik/linux.html"
DESCRIPTION="Transparent OSS emulation on top of the Network Audio System"
SRC_URI="http://romeo.skybert.no/~erik/audiooss-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

RDEPEND="media-libs/nas
	|| ( x11-libs/libX11 virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( ( x11-misc/gccmakedep
			x11-misc/imake )
		virtual/x11 )"

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
