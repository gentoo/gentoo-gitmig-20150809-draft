# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xli/xli-1.17.0.ebuild,v 1.14 2004/07/14 18:33:40 agriffis Exp $

inherit alternatives

DESCRIPTION="X Load Image: view images or load them to root window"
SRC_URI="ftp://ftp.freebsd.org/pub/FreeBSD/ports/distfiles/${P}.tar.gz"
HOMEPAGE="http://pantransit.reptiles.org/prog/"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86 ppc hppa ~amd64"
IUSE=""

DEPEND="virtual/x11
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.0.5
	>=media-libs/jpeg-6b-r2"

src_unpack() {

	unpack ${A}

	cd ${S}

	sed -i Imakefile \
		-e "/^DEFINES =/s/$/ -DHAVE_GUNZIP/" \
		-e "/CCOPTIONS =/s/=.*/=/"

	# This is a hack to avoid a parse error on /usr/include/string.h
	# when _BSD_SOURCE is defined. This may be a bug in that header.
	sed	-i png.c \
		-e "/^#include \"xli.h\"/i#undef _BSD_SOURCE"

	# This hack will allow xli to compile using gcc-3.3
	sed -i rlelib.c \
		-e "s/#include <varargs.h>//"

}

src_compile() {

	/usr/X11R6/bin/xmkmf || die

	emake CDEBUGFLAGS="${CFLAGS}" || die
}


src_install() {
	into /usr
	dobin xli xlito
	dodoc README README.xloadimage ABOUTGAMMA TODO chkgamma.jpg
	newman xli.man xli.1
	newman xliguide.man xliguide.1
	newman xlito.man xlito.1
	#dosym /usr/bin/xli /usr/bin/xview
	#dosym /usr/bin/xli /usr/bin/xsetbg

	insinto /etc/X11/app-defaults
	newins ${FILESDIR}/Xli.ad Xli || die
	fperms a+r /etc/X11/app-defaults/Xli
}

update_alternatives() {
	alternatives_makesym /usr/bin/xview \
		/usr/bin/{xloadimage,xli}
	alternatives_makesym /usr/bin/xsetbg \
		/usr/bin/{xloadimage,xli}
	alternatives_makesym /usr/share/man/man1/xview.1.gz \
		/usr/share/man/man1/{xloadimage,xli}.1.gz
	alternatives_makesym /usr/share/man/man1/xsetbg.1.gz \
		/usr/share/man/man1/{xloadimage,xli}.1.gz
}

pkg_postinst() {
	update_alternatives
}

pkg_postrm() {
	update_alternatives
}
