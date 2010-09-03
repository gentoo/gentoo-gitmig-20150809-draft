# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/sdlmame/sdlmame-0.139_p2.ebuild,v 1.1 2010/09/03 08:29:44 mr_bones_ Exp $

EAPI=2
inherit eutils flag-o-matic games

MY_PV=${PV/.}
MY_CONF_PN=${PN/sdl}
MY_P=${PN}${MY_PV}
MY_P=${MY_P%%_p*}
DESCRIPTION="Multiple Arcade Machine Emulator (SDL)"
HOMEPAGE="http://mamedev.org/"
UPDATES="$(for PATCH_VER in $(seq 1 ${PV##*_p}) ; do echo "mirror://gentoo/${MY_P}u${PATCH_VER}_diff.zip"; done)"
# Upstream doesn't allow fetching with unknown User-Agent such as wget
SRC_URI="mirror://gentoo/${MY_P/sdl}s.zip $UPDATES"

LICENSE="XMAME"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug opengl"

RDEPEND=">=media-libs/libsdl-1.2.10[audio,joystick,opengl?,video]
	dev-libs/expat
	x11-libs/libXinerama
	debug? (
		x11-libs/gtk+:2
		gnome-base/gconf
	)"
DEPEND="${RDEPEND}
	app-arch/unzip
	x11-proto/xineramaproto"

S=${WORKDIR}

# Function to disable a makefile option
disable_feature() {
	sed -i \
		-e "/$1.*=/s:^:# :" \
		"${S}"/makefile \
		|| die "sed failed"
}

# Function to enable a makefile option
enable_feature() {
	sed -i \
		-e "/^#.*$1.*=/s:^# ::"  \
		"${S}"/makefile \
		|| die "sed failed"
}

src_unpack() {
	base_src_unpack
	unpack ./mame.zip
	rm -f mame.zip
}

src_prepare() {
	if [[ $PV == *_p* ]] ; then
		einfo "Patching release with source updates"
		epatch ${MY_PV%%_p*}*.diff
	fi
	sed -i \
		-e '/CFLAGS += -O$(OPTIMIZE)/s:^:# :' \
		-e '/CFLAGS += -pipe/s:^:# :' \
		-e '/LDFLAGS += -s/s:^:# :' \
		-e '/LDFLAGS =/d' \
		-e 's:-Werror::' \
		makefile \
		|| die "sed failed"
	# Don't compile zlib and expat
	einfo "Disabling embedded libraries: zlib and expat"
	disable_feature BUILD_ZLIB
	disable_feature BUILD_EXPAT

	if use amd64; then
		einfo "Enabling 64-bit support"
		enable_feature PTR64
	fi

	if use ppc; then
		einfo "Enabling PPC support"
		enable_feature BIGENDIAN
	fi

	if use debug; then
		einfo "Enabling DEBUG support"
		enable_feature DEBUG
	fi
}

src_compile() {
	local make_opts

	use opengl || make_opts="${make_opts} NO_OPENGL=1"

	emake \
		NAME="${PN}" \
		OPT_FLAGS='-DINI_PATH=\"\$$HOME/.'${PN}'\;'"${GAMES_SYSCONFDIR}/${PN}"'\"'" ${CXXFLAGS}" \
		CC="${CXX}" \
		SUFFIX="" \
		${make_opts} \
		all \
		|| die "emake failed"
}

src_install() {
	dogamesbin ${PN}$(use amd64 && echo 64) || die

	# Avoid collision on /usr/games/bin/jedutil
	exeinto "$(games_get_libdir)/${PN}"
	doexe chdman jedutil ldverify romcmp testkeys || die
	doman src/osd/sdl/man/{chdman,jedutil,ldverify,romcmp,testkeys}.1
	newman src/osd/sdl/man/mame.1 ${PN}.1

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r src/osd/sdl/keymaps || die "doins -r keymaps failed"

	insinto "${GAMES_SYSCONFDIR}/${PN}"
	doins "${FILESDIR}"/{joymap.dat,vector.ini} || die "doins joymap.dat vector.ini failed"

	sed \
		-e "s:@GAMES_SYSCONFDIR@:${GAMES_SYSCONFDIR}:" \
		-e "s:@GAMES_DATADIR@:${GAMES_DATADIR}:" \
		"${FILESDIR}"/mame.ini.in > "${D}/${GAMES_SYSCONFDIR}/${PN}/"mame.ini \
		|| die "sed failed"

	dodoc docs/{config,mame,newvideo}.txt whatsnew*.txt

	keepdir \
		"${GAMES_DATADIR}/${PN}"/{roms,samples,artwork} \
		"${GAMES_SYSCONFDIR}/${PN}"/ctrlr

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "It's strongly recommended that you change either the system-wide"
	elog "${MY_CONF_PN}.ini at \"${GAMES_SYSCONFDIR}/${PN}\" or use a per-user setup at \$HOME/.${PN}"

	if use opengl; then
		echo
		elog "You built ${PN} with opengl support and should set"
		elog "\"video\" to \"opengl\" in ${MY_CONF_PN}.ini to take advantage of that"
	fi
}
