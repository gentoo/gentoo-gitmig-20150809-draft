# Copyright 1999-2000 Gentoo Technologies, Inc.
# Author Achim Gottinger <achim@gentoo.org> 
# /home/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.5.10-r6.ebuild,v 1.1 2001/10/02 20:34:44 woodchip Exp

DESCRIPTION="Advanced Linux Sound Architecture Utils"
HOMEPAGE="http://www.alsa-project.org/"

SRC_URI="ftp://ftp.alsa-project.org/pub/utils/${P/_rc/rc}.tar.bz2"
S=${WORKDIR}/${P/_rc/rc}

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	=media-libs/alsa-lib-0.9.0_rc1"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		|| die "./configure failed"
	emake || die "Parallel Make Failed"
}

src_install() {
	ALSA_UTILS_DOCS="COPYING ChangeLog README TODO 
			seq/aconnect/README.aconnect 
			seq/aseqnet/README.aseqnet"
	
	make DESTDIR=${D} install || die "Installation Failed"
	
	dodoc ${ALSA_UTILS_DOCS}
	newdoc alsamixer/README README.alsamixer
	exeinto /etc/init.d 
	newexe ${FILESDIR}/alsa.rc6 alsa
}
