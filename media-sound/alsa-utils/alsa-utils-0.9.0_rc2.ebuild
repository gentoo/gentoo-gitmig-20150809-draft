# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.9.0_rc2.ebuild,v 1.3 2002/07/19 12:27:49 seemant Exp $

S=${WORKDIR}/${P/_rc/rc}
DESCRIPTION="Advanced Linux Sound Architecture Utils"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="ftp://ftp.alsa-project.org/pub/utils/${P/_rc/rc}.tar.bz2"

DEPEND=">=sys-libs/ncurses-5.1
	~media-libs/alsa-lib-0.9.0_rc2"

SLOT="0.9"
LICENSE="GPL-2"
KEYWORDS="x86"

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
