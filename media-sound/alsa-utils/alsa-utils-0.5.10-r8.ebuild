# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.5.10-r8.ebuild,v 1.13 2004/06/06 04:28:39 vapier Exp $

inherit eutils

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/utils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.5"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.1
	>=media-libs/alsa-lib-0.5.10"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/alsa-utils-0.5.10-aplay-destdir.diff
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ChangeLog README
	dodoc seq/aconnect/README.aconnect
	dodoc seq/aseqnet/README.aseqnet
	newdoc alsamixer/README README.alsamixer

	exeinto /etc/init.d ; newexe ${FILESDIR}/alsa-0.5.10 alsa
}
