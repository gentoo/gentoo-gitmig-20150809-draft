# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rplay/rplay-3.3.2.ebuild,v 1.1 2003/07/03 16:41:32 taviso Exp $

DESCRIPTION="Play sounds on remote Unix systems, without sending audio data over the network."
HOMEPAGE="http://rplay.doit.org/"
SRC_URI="http://rplay.doit.org/dist/${P}.tar.gz
	http://ftp.debian.org/debian/pool/main/r/rplay/rplay_3.3.2-8.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE=""
DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

pkg_setup() {
		enewgroup "rplayd" ""
		enewuser "rplayd" "" "" "" "rplayd"
}				
	
src_unpack() {
	unpack ${P}.tar.gz
	epatch ${DISTDIR}/rplay_3.3.2-8.diff.gz
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--enable-rplayd-user="rplayd" \
		--enable-rplayd-group="rplayd" || die "./configure failed"
		
	emake || die
}

src_install() {
	einstall || die
}
