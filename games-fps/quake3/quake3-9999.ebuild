# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3/quake3-9999.ebuild,v 1.7 2006/10/19 22:09:38 wolf31o2 Exp $

# quake3-9999          -> latest svn
# quake3-9999.REV      -> use svn REV
# quake3-VER_alphaREV  -> svn snapshot REV for version VER
# quake3-VER           -> normal quake release

if [[ ${PV} == 9999* ]] ; then
	[[ ${PV} == 9999.* ]] && ESVN_UPDATE_CMD="svn up -r ${PV/9999./}"
	ESVN_REPO_URI="svn://svn.icculus.org/quake3/trunk"
	inherit subversion flag-o-matic toolchain-funcs eutils games

	SRC_URI=""
	S=${WORKDIR}/trunk
elif [[ ${PV} == *_alpha* ]] ; then
	inherit flag-o-matic toolchain-funcs eutils games

	MY_PV=${PV/_alpha*/}
	SNAP=${PV/*_alpha/}
	MY_P=${PN}-${MY_PV}_SVN${SNAP}M
	SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
	S=${WORKDIR}/${MY_P}
else
	inherit flag-o-matic toolchain-funcs eutils games
	MY_PV=${PV/_/-}
	MY_P=io${PN}_${MY_PV}
	SRC_URI="http://icculus.org/quake3/files/${MY_P}.tar.bz2"
	S=${WORKDIR}/${MY_P}
fi

DESCRIPTION="Quake III Arena - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://icculus.org/quake3/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE="dedicated opengl teamarena"

UIRDEPEND="virtual/opengl
	media-libs/openal
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	media-libs/libsdl"

RDEPEND="opengl? (
	${UIRDEPEND} )
	!dedicated? (
		${UIRDEPEND} )
	games-fps/quake3-data
	teamarena? ( games-fps/quake3-teamarena )"

src_unpack() {
	if [[ ${PV} == 9999* ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
		cd "${S}"
	fi
}

src_compile() {
	filter-flags -mfpmath=sse
	buildit() { use $1 && echo 1 || echo 0 ; }
	emake \
		BUILD_SERVER=$(buildit dedicated) \
		BUILD_CLIENT=$(buildit opengl) \
		TEMPDIR="${T}" \
		CC="$(tc-getCC)" \
		ARCH=$(tc-arch-kernel) \
		OPTIMIZE="${CFLAGS}" \
		DEFAULT_BASEDIR="${GAMES_DATADIR}/quake3" \
		DEFAULT_LIBDIR="${GAMES_LIBDIR}/quake3" \
		|| die
}

src_install() {
	dodoc id-readme.txt TODO README BUGS ChangeLog
	cd code/unix
	dodoc README.*

	if use opengl ; then
		doicon quake3.png
		make_desktop_entry quake3 "Quake III Arena"
	fi

	cd ../../build/release*
	local old_x x
	for old_x in ioq* ; do
		x=${old_x%.*}
		newgamesbin ${old_x} ${x} || die "newgamesbin ${x}"
		dosym ${x} "${GAMES_BINDIR}"/${x/io}
	done
	exeinto "${GAMES_LIBDIR}"/${PN}/baseq3
	doexe baseq3/*.so || die "baseq3 .so"
	exeinto "${GAMES_LIBDIR}"/${PN}/missionpack
	doexe missionpack/*.so || die "missionpack .so"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "The source version of Quake 3 will not work with Punk Buster."
	ewarn "If you need pb support, then use the quake3-bin package."
	echo
}
