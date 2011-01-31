# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3/quake3-1.36.ebuild,v 1.3 2011/01/31 00:30:47 mr_bones_ Exp $

# quake3-9999          -> latest svn
# quake3-9999.REV      -> use svn REV
# quake3-VER_alphaREV  -> svn snapshot REV for version VER
# quake3-VER           -> normal quake release

EAPI=2
if [[ ${PV} == 9999* ]] ; then
	[[ ${PV} == 9999.* ]] && ESVN_UPDATE_CMD="svn up -r ${PV/9999./}"
	ESVN_REPO_URI="svn://svn.icculus.org/quake3/trunk"
	inherit subversion flag-o-matic toolchain-funcs eutils games

	SRC_URI=""
	KEYWORDS=""
	S=${WORKDIR}/trunk
else
	inherit flag-o-matic toolchain-funcs eutils games
	SRC_URI="http://ioquake3.org/files/${PV}/ioquake3-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
	S=${WORKDIR}/io${P}
fi

DESCRIPTION="Quake III Arena - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://ioquake3.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="dedicated teamarena"

DEPEND="!dedicated? (
	virtual/opengl
	media-libs/openal
	media-libs/libsdl[joystick,opengl]
	)"
RDEPEND="${DEPEND}
	games-fps/quake3-data
	teamarena? ( games-fps/quake3-teamarena )"

src_unpack() {
	if [[ ${PV} == 9999* ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
	fi
}

src_prepare() {
	sed -i -e '/INSTALL/s: -s : :' Makefile || die
	if [[ ${PV} != 9999* ]] ; then
		epatch "${FILESDIR}"/${P}-bots.patch
	fi
}

src_compile() {
	filter-flags -mfpmath=sse
	buildit() { use $1 && echo 1 || echo 0 ; }
	emake \
		V=1 \
		BUILD_SERVER=1 \
		BUILD_CLIENT=$(( $(buildit !dedicated) )) \
		TEMPDIR="${T}" \
		CC="$(tc-getCC)" \
		ARCH=$(tc-arch-kernel) \
		OPTIMIZE="${CFLAGS}" \
		DEFAULT_BASEDIR="${GAMES_DATADIR}/quake3" \
		DEFAULT_LIBDIR="$(games_get_libdir)/quake3" \
		Q3ASM_CFLAGS="${CFLAGS}" \
		|| die
}

src_install() {
	dodoc id-readme.txt TODO README BUGS ChangeLog

	if ! use dedicated ; then
		doicon misc/quake3.png
		make_desktop_entry quake3 "Quake III Arena"
	fi

	cd build/release*
	local old_x x
	for old_x in ioq* ; do
		x=${old_x%.*}
		newgamesbin ${old_x} ${x} || die "newgamesbin ${x}"
		dosym ${x} "${GAMES_BINDIR}"/${x/io}
	done
	exeinto "$(games_get_libdir)"/${PN}/baseq3
	doexe baseq3/*.so || die "baseq3 .so"
	exeinto "$(games_get_libdir)"/${PN}/missionpack
	doexe missionpack/*.so || die "missionpack .so"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "The source version of Quake 3 will not work with Punk Buster."
	ewarn "If you need pb support, then use the quake3-bin package."
	echo
}
