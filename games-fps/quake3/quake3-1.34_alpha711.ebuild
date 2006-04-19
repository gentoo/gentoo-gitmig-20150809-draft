# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3/quake3-1.34_alpha711.ebuild,v 1.1 2006/04/19 23:43:44 vapier Exp $

# quake3-9999          -> latest svn
# quake3-9999.REV      -> use svn REV
# quake3-VER_alphaREV  -> svn snapshot REV for version VER
# quake3-VER           -> normal quake release

if [[ ${PV} == 9999* ]] ; then
	[[ ${PV} == 9999.* ]] && ESVN_UPDATE_CMD="svn up -r ${PV/9999./}"
	ESVN_REPO_URI="svn://svn.icculus.org/quake3/trunk"
	inherit subversion toolchain-funcs eutils games

	SRC_URI=""
	S=${WORKDIR}/trunk
elif [[ ${PV} == *_alpha* ]] ; then
	inherit toolchain-funcs eutils games

	MY_PV=${PV/_alpha*/}
	SNAP=${PV/*_alpha/}
	MY_P=${PN}-${MY_PV}_SVN${SNAP}M
	SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
	S=${WORKDIR}/${MY_P}
else
	inherit toolchain-funcs eutils games

	SRC_URI="http://icculus.org/quake3/${P}.tar.bz2"
fi

DESCRIPTION="Quake III Arena - 3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://icculus.org/quake3/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated opengl"

RDEPEND="opengl? (
	virtual/opengl
	media-libs/openal
	|| (
		(
			x11-libs/libXext
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp )
		virtual/x11 )
	media-libs/libsdl )
	!dedicated? (
		virtual/opengl
		|| (
			(
				x11-libs/libXext
				x11-libs/libX11
				x11-libs/libXau
				x11-libs/libXdmcp )
			virtual/x11 )
		media-libs/libsdl )
	games-fps/quake3-data
	teamarena? ( games-fps/quake3-teamarena )"

src_unpack() {
	if [[ ${PV} == 9999* ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
	fi
	# This is a dirty hack around bug #121428 and should be removed once the
	# upstream bug https://bugzilla.icculus.org/show_bug.cgi?id=2634 has been
	# resolved.
	sed -i -e 's|botlib.log|/dev/null|' ${S}/code/botlib/be_interface.c
}

src_compile() {
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
