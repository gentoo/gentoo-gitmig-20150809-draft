# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.9.0_rc6.ebuild,v 1.4 2002/12/31 15:13:51 doctomoe Exp $

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
DEPEND=">=sys-libs/ncurses-5.1
	~media-libs/alsa-lib-0.9.0_rc6"

SLOT="0.9"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

SRC_URI="ftp://ftp.alsa-project.org/pub/utils/${P/_rc/rc}.tar.bz2"
S=${WORKDIR}/${P/_rc/rc}

src_compile() {

	econf || die "./configure failed"
	emake || die "Parallel Make Failed"
}

src_install() {
	local ALSA_UTILS_DOCS="COPYING ChangeLog README TODO 
		seq/aconnect/README.aconnect 
		seq/aseqnet/README.aseqnet"
	
	make DESTDIR=${D} install || die "Installation Failed"
	
	dodoc ${ALSA_UTILS_DOCS}
	newdoc alsamixer/README README.alsamixer
}
