# Copyright 1999-2000 Gentoo Technologies, Inc.
# Author Achim Gottinger <achim@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.9.0_rc2.ebuild,v 1.1 2002/06/20 20:37:18 agenkin Exp $

DESCRIPTION="Advanced Linux Sound Architecture Utils"
HOMEPAGE="http://www.alsa-project.org/"

SRC_URI="ftp://ftp.alsa-project.org/pub/utils/${P/_rc/rc}.tar.bz2"
S=${WORKDIR}/${P/_rc/rc}

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	~media-libs/alsa-lib-0.9.0_rc2"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		|| die "./configure failed"
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
