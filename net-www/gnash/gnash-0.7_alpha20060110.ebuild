# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-0.7_alpha20060110.ebuild,v 1.1 2006/01/10 21:52:08 genstef Exp $

inherit cvs

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
SRC_URI=""
ECVS_SERVER="cvs.sv.gnu.org:/sources/${PN}"
ECVS_MODULE="${PN}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
ECVS_CO_OPTS="-D ${PV/0.7_alpha}"
ECVS_UP_OPTS="-dP ${ECVS_CO_OPTS}"
S=${WORKDIR}/${ECVS_MODULE}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	|| ( ( x11-libs/libX11
	x11-libs/libXt
	x11-proto/xproto )
	virtual/x11 )
	dev-libs/libxml2
	media-libs/libsdl
	media-libs/libmad
	sys-libs/gpm
	sys-libs/ncurses
	sys-libs/slang
	media-libs/sdl-mixer"
RDEPEND="${DEPEND}"

src_compile() {
	libtoolize --copy --force || die "libtoolize --copy --force failed"
	./autogen.sh || die "autogen.sh failed"
	econf \
		--with-libxml-includes=/usr/include/libxml2 \
		--with-x \
		--enable-mp3 \
		--disable-plugin \
		|| die "econf failed"
# plugin disabled, because gnash does not work perfectly yet ..
#  --with-firefox=PFX   Prefix where firefox is installed (optional)
#  --with-firefox-libraries=DIR   Directory where firefox library is installed (optional)
#  --with-firefox-includes=DIR   Directory where firefox header files are installed (optional)
	emake || die "emake failed"

}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	ewarn "ALPHA"
	ewarn "gnash is still in heavy development"
	ewarn "please report gnash bugs upstream to the gnash devs"
}
