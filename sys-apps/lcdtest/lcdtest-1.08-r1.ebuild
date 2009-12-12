# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lcdtest/lcdtest-1.08-r1.ebuild,v 1.9 2009/12/12 13:58:37 chainsaw Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Displays test patterns to spot dead/hot pixels on LCD screens"
HOMEPAGE="http://www.brouhaha.com/~eric/software/lcdtest/"
SRC_URI="http://www.brouhaha.com/~eric/software/lcdtest/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
RDEPEND=">=media-libs/libsdl-1.2.7-r2
	>=media-libs/sdl-image-1.2.3-r1"
DEPEND="$RDEPEND
	>=media-libs/netpbm-10.28
	>=sys-apps/sed-4.1.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-help-option.patch"
}

src_compile() {
	tc-export CC CXX
	cd "${S}/src"
	einfo "Generating font"
	pngtopnm 14P_Arial_Plain_Red.png > help_font.ppm || die pngtopnm failed
	ppmtoxpm -name `basename help_font.ppm .ppm`_xpm help_font.ppm 2>/dev/null |
	sed 's/static //;s/black/#000000/;s/magenta/#FF00FF/;s/#E40808/#009900/' > help_font.c || ppmtoxpm or sed failed
	eend $?
	ebegin "Running first stage compilation"
	"${CC}" -o lcdtest.o -c ${CFLAGS} -DRELEASE=${PV} lcdtest.c || die lcdtest compilation failed
	"${CC}" -o SFont.o -c ${CFLAGS} -DRELEASE=${PV} SFont.c || die SFont compilation failed
	eend $?
	ebegin "Running final stage compilation"
	"${CC}" -o help_font.o -c ${CFLAGS} -DRELEASE=${PV} help_font.c || die help_font compilation failed
	"${CC}" "${LDFLAGS}" -o lcdtest lcdtest.o SFont.o help_font.o -lSDL -lSDL_image || die final link failed
	eend $?
}

src_install() {
	dobin src/lcdtest || die Binary missing
	doman man/lcdtest.1 || die Manpage missing
	dodoc README || die Documentation missing
}
