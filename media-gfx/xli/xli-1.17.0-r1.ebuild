# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xli/xli-1.17.0-r1.ebuild,v 1.11 2005/03/18 23:39:25 cryos Exp $

inherit alternatives

SNAPSHOT="2005-02-27"
DESCRIPTION="X Load Image: view images or load them to root window"
HOMEPAGE="http://pantransit.reptiles.org/prog/"
SRC_URI="http://pantransit.reptiles.org/prog/xli/xli-${SNAPSHOT}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ~ppc-macos sparc x86 ppc-macos ~mips"
IUSE=""

DEPEND="virtual/x11
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.0.5
	>=media-libs/jpeg-6b-r2
	app-arch/bzip2"

S=${WORKDIR}/${PN}-${SNAPSHOT}

src_unpack() {
	unpack ${A}

	cd ${S}

	if use ppc-macos ; then
		for f in $(grep zopen * | cut -d':' -f1 | uniq); do
			sed -i "s:zopen:xli_zopen:g" $f
		done
	fi

	sed -i Imakefile \
		-e "/^DEFINES =/s/$/ -DHAVE_GUNZIP -DHAVE_BUNZIP2 /" \
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
	xmkmf || die "xmkmf failed."

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
	use ppc-macos || update_alternatives
}

pkg_postrm() {
	use ppc-macos || update_alternatives
}
