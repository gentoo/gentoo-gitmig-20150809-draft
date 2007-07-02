# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/industri/industri-1.01.ebuild,v 1.14 2007/07/02 17:28:03 nyhm Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Quake/Tenebrae based, single player game"
HOMEPAGE="http://industri.sourceforge.net/"
SRC_URI="mirror://sourceforge/industri/industri_BIN-${PV}-src.tar.gz
	mirror://sourceforge/industri/industri-1.00.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="cdinstall"

RDEPEND="virtual/opengl
	media-libs/mesa
	x11-libs/libXxf86dga
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXxf86vm
	media-libs/libpng
	cdinstall? ( games-fps/quake1-data )"
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

	epatch "${FILESDIR}"/${P}-exec-stack.patch
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
	if ! use cdinstall
	then
		elog "You need to copy pak0.pak to ${GAMES_DATADIR}/quake1 to play."
	fi
}
