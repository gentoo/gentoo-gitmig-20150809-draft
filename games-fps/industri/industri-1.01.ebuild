# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/industri/industri-1.01.ebuild,v 1.12 2006/12/05 17:08:32 wolf31o2 Exp $

inherit toolchain-funcs games

DESCRIPTION="Quake/Tenebrae based, single player game"
HOMEPAGE="http://industri.sourceforge.net/"
SRC_URI="mirror://sourceforge/industri/industri_BIN-${PV}-src.tar.gz
	mirror://sourceforge/industri/industri-1.00.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/opengl
	media-libs/mesa
	x11-libs/libXxf86dga
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXxf86vm
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}
	x11-proto/xf86dgaproto
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto
	app-arch/unzip"

S=${WORKDIR}/industri_BIN

src_unpack() {
	unpack ${A}

	cd "${S}"/linux
	mv Makefile.i386linux Makefile
	sed -i -e "s:-mpentiumpro.*:${CFLAGS} \\\\:" Makefile || die "sed failed"

	# Remove duplicated typedefs #71841
	cd "${S}"
	for typ in PFNGLFLUSHVERTEXARRAYRANGEAPPLEPROC PFNGLVERTEXARRAYRANGEAPPLEPROC ; do
		if echo '#include <GL/gl.h>' | $(tc-getCC) -E - 2>/dev/null | grep -sq ${typ} ; then
			sed -i \
				-e "/^typedef.*${typ}/d" \
				glquake.h \
				|| die "sed failed"
		fi
	done
}

src_compile() {
	emake \
		-C linux \
		MASTER_DIR="${GAMES_DATADIR}"/quake1 \
		build_release \
		|| die "emake failed"
}

src_install() {
	newgamesbin linux/release*/bin/industri.run industri || die
	dogamesbin "${FILESDIR}"/industri.pretty || die
	insinto /usr/share/icons
	doins industri.ico quake.ico
	dodoc linux/README
	cd "${WORKDIR}"/industri
	dodoc *.txt && rm *.txt
	insinto "${GAMES_DATADIR}"/quake1/industri
	doins *
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Please setup your quake pak files before playing in"
	einfo "${GAMES_DATADIR}/quake1"
}
