# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-libraries/em8300-libraries-0.15.0_pre20040525.ebuild,v 1.3 2004/09/01 23:58:34 arj Exp $

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card libraries"
HOMEPAGE="http://dxr3.sourceforge.net"
PDATE="20040525"
SRC_URI="mirror://gentoo/em8300-${PDATE}.tar.bz2
	http://dev.gentoo.org/~arj/files/em8300-${PDATE}.tar.bz2"

DEPEND="media-video/em8300-modules
	gtk? ( x11-libs/gtk+ )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="gtk"

S="${WORKDIR}/em8300-${PDATE}"

src_unpack () {

	unpack ${A}

	cd ${S}
	#Eliminate extra compiling and prune out some disk space usage
	sed -e "s:modules/\ ::g" \
	    -e "s:\ modules.tar.gz::g" \
	    Makefile.in > Makefile.in.hacked
	mv Makefile.in.hacked Makefile.in

	cd em8300setup
	mv em8300setup.c em8300setup.c.old
	sed -e "s:/usr/share/misc/em8300.uc:/usr/share/em8300/em8300.uc:g" \
	       < em8300setup.c.old > em8300setup.c
	rm em8300setup.c.old

}

src_compile ()	{

	local myconf
	use gtk || myconf="${myconf} --disable-gtktest"

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
