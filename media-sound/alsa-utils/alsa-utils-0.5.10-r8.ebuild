# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.5.10-r6.ebuild,v 1.1 2001/10/02 20:34:44 woodchip Exp

S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture / Utils"
SRC_URI="ftp://ftp.alsa-project.org/pub/utils/${P}.tar.bz2"
HOMEPAGE="http://www.alsa-project.org/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=media-libs/alsa-lib-0.5.10"

src_unpack() {

	unpack ${A} ; cd ${S}
	patch -p1 < ${FILESDIR}/alsa-utils-0.5.10-aplay-destdir.diff || die
}

src_compile() {

	./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} || die
	make || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc COPYING ChangeLog README
	dodoc seq/aconnect/README.aconnect
	dodoc seq/aseqnet/README.aseqnet
	newdoc alsamixer/README README.alsamixer

	exeinto /etc/init.d ; newexe ${FILESDIR}/alsa-0.5.10 alsa
}
