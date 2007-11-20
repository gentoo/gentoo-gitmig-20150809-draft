# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake2-icculus/quake2-icculus-0.16.1-r1.ebuild,v 1.7 2007/11/20 02:17:48 mr_bones_ Exp $

inherit eutils toolchain-funcs games

MY_P="quake2-r${PV}"
DESCRIPTION="The icculus.org Linux port of iD's Quake 2 engine"
HOMEPAGE="http://icculus.org/quake2/"
SRC_URI="http://icculus.org/quake2/files/${MY_P}.tar.gz
	qmax? ( http://icculus.org/quake2/files/maxpak.pak )
	rogue? ( mirror://idsoftware/quake2/source/roguesrc320.shar.Z )
	xatrix? ( mirror://idsoftware/quake2/source/xatrixsrc320.shar.Z )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="aalib alsa arts cdinstall dedicated demo ipv6 joystick opengl qmax rogue sdl svga X xatrix"

UIDEPEND="aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	opengl? ( virtual/opengl )
	svga? ( media-libs/svgalib )
	sdl? ( media-libs/libsdl )"
RDEPEND="${UIDEPEND}
	cdinstall? ( games-fps/quake2-data )
	demo? ( games-fps/quake2-demodata )"
DEPEND="${UIDEPEND}
	X? (
		x11-proto/xproto
		x11-proto/xextproto
		x11-proto/xf86dgaproto
		x11-proto/xf86vidmodeproto )
	rogue? ( || ( sys-freebsd/freebsd-ubin app-arch/sharutils ) )
	xatrix? ( || ( sys-freebsd/freebsd-ubin app-arch/sharutils ) )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	games_pkg_setup

	local alert_user

	if ! use qmax && $( use opengl || use sdl ) ; then
		einfo "The 'qmax' graphical improvements are recommended."
		echo
		alert_user=y
	fi

	if ! use sdl ; then
		ewarn "The ALSA sound driver for this game is broken."
		ewarn "The 'sdl' USE flag is recommended instead."
		echo
		alert_user=y
	fi

	if [[ -n "${alert_user}" ]] ; then
		ebeep
		epause
	fi
}

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd "${S}"
	sed -i -e 's:BUILD_SOFTX:BUILD_X11:' Makefile
	epatch "${FILESDIR}"/${P}-amd64.patch # make sure this is still needed in future versions
	epatch "${FILESDIR}"/${P}-gentoo-paths.patch

	# Now we deal with the silly rogue / xatrix addons ... this is ugly :/
	ln -s $(type -P echo) "${T}"/more
	for g in rogue xatrix ; do
		use ${g} || continue
		mkdir -p "${S}"/src/${g}
		cd "${S}"/src/${g}
		local shar=${g}src320.shar
		unpack ${shar}.Z
		sed -i \
			-e 's:^read ans:ans=yes :' ${shar} \
			|| die "sed ${shar} failed"
		echo ">>> Unpacking ${shar} to ${PWD}"
		env PATH=${T}:${PATH} unshar ${shar} || die "unpacking ${shar} failed"
		rm ${shar}
	done
	if use xatrix ; then
		epatch "${FILESDIR}/${P}"-gcc41.patch
	fi
	if use rogue ; then
		cd "${S}"/src
		epatch "${FILESDIR}"/0.16-rogue-nan.patch
		epatch "${FILESDIR}"/0.16-rogue-armor.patch
	fi
}

yesno() {
	for f in "$@" ; do
		if ! use $f ; then
			echo NO
			return 1
		fi
	done
	echo YES
	return 0
}

src_compile() {
	# xatrix fails to build
	# rogue fails to build
	local libsuffix
	for BUILD_QMAX in YES NO ; do
		use qmax && [[ ${BUILD_QMAX} == "NO" ]] && continue
		[[ ${BUILD_QMAX} == "YES" ]] \
			&& libsuffix=-qmax \
			|| libsuffix=
		make clean || die "cleaning failed"
		emake -j1 build_release \
			BUILD_SDLQUAKE2=$(yesno sdl) \
			BUILD_SVGA=$(yesno svga) \
			BUILD_X11=$(yesno X) \
			BUILD_GLX=$(yesno opengl) \
			BUILD_SDL=$(yesno sdl) \
			BUILD_SDLGL=$(yesno sdl opengl) \
			BUILD_CTFDLL=YES \
			BUILD_XATRIX=$(yesno xatrix) \
			BUILD_ROGUE=$(yesno rogue) \
			BUILD_JOYSTICK=$(yesno joystick) \
			BUILD_DEDICATED=$(yesno dedicated) \
			BUILD_AA=$(yesno aalib) \
			BUILD_QMAX=${BUILD_QMAX} \
			HAVE_IPV6=$(yesno ipv6) \
			BUILD_ARTS=$(yesno arts) \
			BUILD_ALSA=$(yesno alsa) \
			SDLDIR=/usr/lib \
			DEFAULT_BASEDIR="${GAMES_DATADIR}/quake2" \
			DEFAULT_LIBDIR="$(games_get_libdir)/${PN}${libsuffix}" \
			OPT_CFLAGS="${CFLAGS}" \
			CC="$(tc-getCC)" \
			|| die "make failed"
		# now we save the build dir ... except for the object files ...
		rm release*/*/*.o
		mv release* my-rel-${BUILD_QMAX}
		cd my-rel-${BUILD_QMAX}
		rm -rf ref_{gl,soft} ded game client ctf/*.o
		mkdir baseq2
		mv game*.so baseq2/
		cd ..
	done
}

src_install() {
	local q2dir=$(games_get_libdir)/${PN}
	local q2maxdir=$(games_get_libdir)/${PN}-qmax

	dodoc readme.txt README TODO "${FILESDIR}"/README-postinstall

	# regular q2 files
	dodir "${q2dir}"
	cp -rf my-rel-NO/* "${D}/${q2dir}"/
	dogamesbin "${D}/${q2dir}"/quake2
	rm "${D}/${q2dir}"/quake2
	use dedicated \
		&& dogamesbin "${D}/${q2dir}"/q2ded \
		&& rm "${D}/${q2dir}"/q2ded
	use sdl \
		&& dogamesbin "${D}/${q2dir}"/sdlquake2 \
		&& rm "${D}/${q2dir}"/sdlquake2

	doicon "${FILESDIR}"/quake2.xpm
	make_desktop_entry quake2 "Quake 2" quake2.xpm

	# q2max files
	if use qmax ; then
		dodir "${q2maxdir}"
		cp -rf my-rel-YES/* "${D}/${q2maxdir}"/
		newgamesbin "${D}/${q2maxdir}"/quake2 quake2-qmax
		newgamesbin "${D}/${q2maxdir}"/q2ded q2ded-qmax
		rm "${D}/${q2maxdir}"/{quake2,q2ded}
		use sdl \
			&& newgamesbin "${D}/${q2maxdir}"/sdlquake2 sdlquake2-qmax \
			&& rm "${D}/${q2maxdir}"/sdlquake2

		insinto "${q2maxdir}"/baseq2
		doins "${DISTDIR}"/maxpak.pak

		make_desktop_entry quake2-qmax Quake2-qmax quake2.xpm
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "Go read /usr/share/doc/${PF}/README-postinstall.gz"
	elog "right now! It's important - This install is just the engine, you still need"
	elog "the data paks. Go read."

	if use demo && ! built_with_use "games-fps/quake2-demodata" symlink ; then
		ewarn "To play the Quake 2 demo,"
		ewarn "emerge games-fps/quake2-demodata with the 'symlink' USE flag."
		echo
	fi
}
