# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-libraries/em8300-libraries-0.13.0.ebuild,v 1.6 2004/07/14 21:33:42 agriffis Exp $

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card libraries"
HOMEPAGE="http://dxr3.sourceforge.net"
SRC_URI="mirror://sourceforge/dxr3/${P/-libraries/}.tar.gz"

DEPEND="media-video/em8300-modules
	x11-libs/gtk+"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""


src_unpack () {

	unpack ${A}
	cd ${WORKDIR}
	mv ${A/.tar.gz/} ${P}

	cd ${S}
	#Eliminate extra compiling and prune out some disk space usage
	sed -e "s:modules/\ ::g" \
	    -e "s:\ modules.tar.gz::g" \
	    Makefile.in > Makefile.in.hacked
	mv Makefile.in.hacked Makefile.in

}

src_compile ()  {

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--datadir=/usr/share || die
	make all || die

}

src_install () {

	cd ${S}/scripts
	mv microcode_upload.pl microcode_upload.pl.old
	sed -e "s:/usr/share/misc/em8300.uc:/usr/share/em8300/em8300.uc:g" \
		< microcode_upload.pl.old > microcode_upload.pl
	rm microcode_upload.pl.old
	cd ${S}

	make em8300incdir=${D}/usr/include/linux/ \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		sysconfdir=/etc \
		oldincludedir=${D}/usr/include \
		install || die

	insinto /usr/share/em8300
	doins modules/em8300.uc

	dodoc AUTHORS COPYING ChangeLog NEWS README

}

pkg_postinst() {

	einfo
	einfo "The em8300 libraries and modules have now beein installed,"
	einfo "you will probably want to add /usr/bin/em8300setup to your"
	einfo "/etc/conf.d/local.start so that your em8300 card is "
	einfo "properly initialized on boot."
	einfo
	einfo "If you still need a microcode other than the one included"
	einfo "with the package, you can simply use em8300setup <microcode.ux>"
	einfo

}
