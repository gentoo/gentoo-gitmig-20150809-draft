# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xloadimage/xloadimage-4.1-r2.ebuild,v 1.1 2005/02/28 15:46:04 taviso Exp $

inherit alternatives eutils flag-o-matic

MY_P="${P/-/.}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="utility to view many different types of images under X11"
HOMEPAGE="http://world.std.com/~jimf/xloadimage.html"
SRC_URI="ftp://ftp.x.org/R5contrib/${MY_P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~ppc-macos"
IUSE="tiff jpeg png"

RDEPEND="virtual/x11
	tiff? ( media-libs/tiff )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-zio-shell-meta-char.diff

	# Do not define errno extern, but rather include errno.h
	# <azarah@gentoo.org> (1 Jan 2003)
	epatch ${FILESDIR}/${P}-include-errno_h.patch

	sed -i "s:OPT_FLAGS=:OPT_FLAGS=$CFLAGS:" Make.conf
	sed -i "s:^#include <varargs.h>:#include <stdarg.h>:" ${S}/rlelib.c

	if use ppc-macos ; then
		sed -i 's,<malloc.h>,<malloc/malloc.h>,' vicar.c
		for f in $(grep zopen * | cut -d':' -f1 | uniq);do
			sed -i "s:zopen:zloadimage_zopen:g" $f
		done
	fi

	chmod +x ${S}/configure
}

src_install() {
	dobin xloadimage
	dobin uufilter

	insinto /etc/X11
	doins xloadimagerc

	newman xloadimage.man xloadimage.1
	newman uufilter.man uufilter.1

	dodoc README
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
