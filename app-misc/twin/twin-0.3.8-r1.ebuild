# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/twin/twin-0.3.8-r1.ebuild,v 1.15 2004/02/17 23:00:34 agriffis Exp $

IUSE="X ggi"

S=${WORKDIR}/${P}
DESCRIPTION="A text-mode window environment"
SRC_URI="mirror://sourceforge/twin/${P}.tar.gz
	http://linuz.sns.it/~max/twin/${P}.tar.gz"
HOMEPAGE="http://linuz.sns.it/~max/twin/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc"

DEPEND="X? ( virtual/x11 )
	ggi? ( >=media-libs/libggi-1.9 )
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	local conf
	conf="\n\n\n\n\n""\n\n\n\n\n""\n\ny\n\n\n""\n\n\n\n"

	use X \
	   && conf=${conf}"y\n" \
	   || conf=${conf}"n\n"

	conf=${conf}"\n\n"
	use ggi \
	   && conf=${conf}"y\n" \
	   || conf=${conf}"n\n"

	conf=${conf}"\n\n""\n\n\n\nn\n"
	echo -e "${conf}" > test
	cat test | make config
	rm test
	make clean || die
	make || die
}

src_install() {

	dodir /usr/lib /usr/bin /usr/lib/ /usr/include /usr/include/Tw \
		/usr/lib/twin/modules /usr/X11R6/lib/X11/fonts/misc

	DESTDIR=${D} make install || die

	use X && ( \
		insinto /usr/X11R6/lib/X11/fonts/misc
		doins fonts/vga.pcf.gz
	)

}

pkg_postinst() {
	use X && ( \
		/usr/X11R6/bin/mkfontdir /usr/X11R6/lib/X11/fonts/misc
		/usr/X11R6/bin/xset fp rehash
	)
}

pkg_postrm() {
	use X && ( \
		/usr/X11R6/bin/mkfontdir /usr/X11R6/lib/X11/fonts/misc
		/usr/X11R6/bin/xset fp rehash
	)
}
