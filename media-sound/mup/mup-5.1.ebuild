# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mup/mup-5.1.ebuild,v 1.8 2007/01/05 17:40:08 flameeyes Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Program for printing music scores"
HOMEPAGE="http://www.arkkra.com/"
SRC_URI="ftp://ftp.arkkra.com/pub/unix/mup${PV//.}src.tar.gz
	ftp://ftp.arkkra.com/pub/unix/mup${PV//.}doc.tar.gz"
#"
LICENSE="Arkkra"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="X svga"

RDEPEND="X? ( || ( x11-libs/libX11 virtual/x11 ) )
	svga? ( >=media-libs/svgalib-1.4.3 )"

DEPEND="${RDEPEND}
	X? ( || ( x11-proto/xextproto virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}css.patch
}

src_compile() {
	local param

	cd ${S}/mup
	echo $(tc-getCC) ${CFLAGS} ${LDFLAGS} -o mup *.c -lm
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o mup *.c -lm || die "mup compile failed"

	cd ${S}/mkmupfnt
	echo $(tc-getCC) ${CFLAGS} ${LDFLAGS} -o mkmupfnt *.c
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o mkmupfnt *.c || die "mkmupfnt compile failed"

	if use X || use svga ; then
		cd ${S}/mupdisp
		if use X ; then
			param="-lX11 -L/usr/X11R6/lib"
		else
			sed -i '/XWINDOW/s:.*::' dispttyp.h
		fi
		if use svga ; then
			param="${param} -lvga"
		else
			param="${param} -DNO_VGA_LIB"
		fi
		echo $(tc-getCC) ${CFLAGS} ${LDFLAGS} -o mupdisp *.c -lm ${param}
		$(tc-getCC) ${CFLAGS} ${LDFLAS} -o mupdisp *.c -lm ${param} || die "mupdisp compile failed"
	fi
}

src_install() {
	dobin mup/mup mkmupfnt/mkmupfnt mupprnt || die
	if use X || use svga ; then
		dobin mupdisp/mupdisp || die
	fi

	dodoc license.txt README0
	cd docs
	dodoc *.txt README1
	doman mup.1 mkmupfnt.1 mupprnt.1
	if use X || use svga ; then
		doman mupdisp.1
	fi
	dohtml uguide/*
	docinto sample
	dodoc *.mup *.ps
}

pkg_postinst() {
	if use svga ; then
		elog "Please note that using mupdisp in SVGA mode on the console"
		elog "requires that it can write to the console device. To allow"
		elog "this, make mupdisp setuid to root, like this:"
		elog
		elog "\tchown root /usr/bin/mupdisp"
		elog "\tchmod u+s /usr/bin/mupdisp"
	fi
	if use X || use svga ; then
		echo
		elog "If you want to use mupdisp, make sure you also install ghostscript."
	fi
}
