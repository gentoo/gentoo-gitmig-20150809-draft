# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-libraries/em8300-libraries-0.12.0.ebuild,v 1.3 2002/07/11 06:30:42 drobbins Exp $

DESCRIPTION="em8300 video decoder card libraries"
HOMEPAGE="http://dxr3.sourceforge.net"

SRC_URI="mirror://sourceforge/dxr3/${P/-libraries/}.tar.gz"

DEPEND="media-video/em8300-modules
        x11-libs/gtk+"

S="${WORKDIR}/${P}"

src_unpack () {

	unpack ${A}
	cd ${WORKDIR}
	mv ${A/.tar.gz/} ${P}

}

src_compile ()  {

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--datadir=/usr/share || die
	make all || die
	
}

src_install () {

	make em8300incdir=${D}/usr/include/linux/ \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		sysconfdir=/etc \
		oldincludedir=${D}/usr/include \
		install || die

	#this isn't how the installer does this, but it makes more
	#sense than copying it like they do.
	dosym /usr/share/em8300/microcode_upload.pl /usr/bin/em8300init

}

pkg_postinst() {

	einfo 
	einfo "The em8300 libraries and modules have now beein installed,"
	einfo "you will probably want to add /usr/bin/em8300init to your"
	einfo "/etc/conf.d/local.start so that your em8300 card is "
	einfo "properly initialized on boot."
	einfo
	einfo "If you still need a microcode other than the one included"
	einfo "with the package, you can simply use em8300init <microcode.ux>"
	einfo 

}
