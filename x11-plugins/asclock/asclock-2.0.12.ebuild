# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asclock/asclock-2.0.12.ebuild,v 1.13 2006/12/08 22:49:02 mr_bones_ Exp $

IUSE=""
DESCRIPTION="Clock applet for AfterStep"
SRC_URI="http://www.tigr.net/afterstep/download/asclock/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/list.pl"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc mips"

DEPEND="x11-libs/libXpm"
RDEPEND="${DEPEND}
	x11-proto/xextproto
	x11-proto/xproto"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	ln -s themes/classic default_theme
}

src_compile() {
	local x
	for x in asclock parser symbols config
	do
		gcc \
			${CFLAGS} \
			-I/usr/X11R6/include \
			-Dlinux -D__i386__ \
			-D_POSIX_C_SOURCE=199309L \
			-D_POSIX_SOURCE \
			-D_XOPEN_SOURCE \
			-D_BSD_SOURCE \
			-D_SVID_SOURCE \
			-DFUNCPROTO=15 \
			-DNARROWPROTO \
			-c -o ${x}.o ${x}.c || die
	done
	gcc \
		${CFLAGS} \
		-o asclock \
		asclock.o parser.o symbols.o config.o \
		-L/usr/X11R6/lib \
		-L/usr/lib/X11 \
		-lXpm -lXext -lX11 || die
}

src_install () {
	dobin asclock
	dodir usr/share/asclock
	cp -pPR themes/* ${D}/usr/share/asclock
	dodoc README README.THEMES TODO
}
