# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.5.10-r8.ebuild,v 1.9 2003/06/12 20:48:23 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
SRC_URI="ftp://ftp.alsa-project.org/pub/utils/${P}.tar.bz2"
HOMEPAGE="http://www.alsa-project.org/"

DEPEND=">=sys-libs/ncurses-5.1
	>=media-libs/alsa-lib-0.5.10"

SLOT="0.5"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_unpack() {

	unpack ${A} ; cd ${S}
	patch -p1 < ${FILESDIR}/alsa-utils-0.5.10-aplay-destdir.diff || die
}

src_compile() {

	econf || die
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
