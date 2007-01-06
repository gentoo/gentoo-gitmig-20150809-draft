# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-libraries/em8300-libraries-0.15.3.ebuild,v 1.3 2007/01/06 14:56:41 zzam Exp $

inherit flag-o-matic

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card libraries"
HOMEPAGE="http://dxr3.sourceforge.net"
SRC_URI="mirror://sourceforge/dxr3/${P/-libraries/}.tar.gz"

DEPEND="media-video/em8300-modules
	gtk? ( x11-libs/gtk+ )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="gtk"

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

	# fix bug in Makefile
	sed -e "s:test -z \"\$(firmwaredir)\":test -z \"\$(DESTDIR)(firmwaredir)\":g" Makefile.am > Makefile.am.hacked
	mv Makefile.am.hacked Makefile.am

}

src_compile ()	{

	use amd64 && append-flags -fPIC

	local myconf
	use gtk || myconf="${myconf} --disable-gtktest"

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--datadir=/usr/share || die
	make all || die

}

src_install () {

	make DESTDIR=${D} em8300incdir=/usr/include/linux/ \
		prefix=/usr \
		datadir=/usr/share \
		sysconfdir=/etc \
		oldincludedir=/usr/include \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README

}

pkg_postinst() {

	elog
	elog "The em8300 libraries and modules have now beein installed,"
	elog "you will probably want to add /usr/bin/em8300setup to your"
	elog "/etc/conf.d/local.start so that your em8300 card is "
	elog "properly initialized on boot."
	elog
	elog "If you still need a microcode other than the one included"
	elog "with the package, you can simply use em8300setup <microcode.ux>"
	elog

}
