# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake2-icculus/quake2-icculus-0.16.ebuild,v 1.3 2005/01/15 00:52:51 vapier Exp $

inherit eutils games

MY_P="quake2-r${PV}"
DESCRIPTION="The icculus.org linux port of iD's quake2 engine"
HOMEPAGE="http://icculus.org/quake2/"
SRC_URI="http://icculus.org/quake2/files/${MY_P}.tar.gz
	!noqmax? ( http://icculus.org/quake2/files/maxpak.pak )
	rogue? ( ftp://ftp.idsoftware.com/idstuff/quake2/source/roguesrc320.shar.Z )
	xatrix? ( ftp://ftp.idsoftware.com/idstuff/quake2/source/xatrixsrc320.shar.Z )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="arts svga sdl aalib dedicated opengl noqmax rogue xatrix ipv6 joystick"

# default to X11 if svga/opengl/sdl/aalib/dedicated are not in USE
RDEPEND="virtual/libc
	opengl? ( virtual/opengl )
	svga? ( media-libs/svgalib )
	sdl? ( media-libs/libsdl )
	aalib? ( media-libs/aalib )
	!svga? ( !opengl? ( !sdl? ( !aalib? ( !dedicated? ( virtual/x11 ) ) ) ) )
	arts? ( kde-base/arts )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	app-arch/sharutils"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	epatch "${FILESDIR}"/${PV}-Makefile-gentoo-opts.patch
	epatch "${FILESDIR}"/${PV}-gentoo-path.patch
	cat << EOF > src/linux/gentoo-paths.h
#define GENTOO_DATADIR "${GAMES_DATADIR}/quake2-data"
#ifdef QMAX
#define GENTOO_LIBDIR "${GAMES_LIBDIR}/${PN}-qmax"
#else
#define GENTOO_LIBDIR "${GAMES_LIBDIR}/${PN}"
#endif
EOF

	# Now we deal with the silly rogue / xatrix addons ... this is ugly :/
	ln -s $(which echo) "${T}"/more
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
		env PATH="${T}:${PATH}" unshar ${shar} || die "unpacking ${shar} failed"
		rm ${shar}
	done
	if use rogue ; then
		cd "${S}"/src
		epatch ${FILESDIR}/${PV}-rogue-nan.patch
	fi
}

yesno() {
	for f in "$@" ; do
		if ! useq $f ; then
			echo NO
			return 1
		fi
	done
	echo YES
	return 0
}

src_compile() {
	BUILD_X11=$(yesno X)
	use sdl || use opengl || use svga || use aalib || BUILD_X11=YES

	# xatrix fails to build
	# rogue fails to build
	for BUILD_QMAX in YES NO ; do
		use noqmax && [ "${BUILD_QMAX}" == "YES" ] && continue
		make clean || die "cleaning failed"
		emake -j1 build_release \
			BUILD_SDLQUAKE2=$(yesno sdl) \
			BUILD_SVGA=$(yesno svga) \
			BUILD_X11=${BUILD_X11} \
			BUILD_GLX=$(yesno opengl) \
			BUILD_SDL=$(yesno sdl) \
			BUILD_SDLGL=$(yesno sdl opengl) \
			BUILD_CTFDLL=YES \
			BUILD_XATRIX=$(yesno xatrix) \
			BUILD_ROGUE=$(yesno rogue) \
			BUILD_JOYSTICK=$(yesno joystick) \
			BUILD_DEDICATED=YES \
			BUILD_AA=$(yesno aalib) \
			BUILD_QMAX=${BUILD_QMAX} \
			HAVE_IPV6=$(yesno ipv6) \
			BUILD_ARTS=$(yesno arts) \
			SDLDIR=/usr/lib \
			OPTCFLAGS="${CFLAGS}" \
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
	local q2dir=${GAMES_LIBDIR}/${PN}
	local q2maxdir=${GAMES_LIBDIR}/${PN}-qmax

	dodoc readme.txt README TODO ${FILESDIR}/README-postinstall

	# regular q2 files
	dodir ${q2dir}
	cp -rf my-rel-NO/* ${D}/${q2dir}/
	dogamesbin ${D}/${q2dir}/{quake2,q2ded}
	rm ${D}/${q2dir}/{quake2,q2ded}
	use sdl && dogamesbin ${D}/${q2dir}/sdlquake2 && rm ${D}/${q2dir}/sdlquake2

	# q2max files
	if ! use noqmax ; then
		dodir ${q2maxdir}
		cp -rf my-rel-YES/* ${D}/${q2maxdir}/
		newgamesbin ${D}/${q2maxdir}/quake2 quake2-qmax
		newgamesbin ${D}/${q2maxdir}/q2ded q2ded-qmax
		rm ${D}/${q2maxdir}/{quake2,q2ded}
		use sdl && newgamesbin ${D}/${q2maxdir}/sdlquake2 sdlquake2-qmax && rm ${D}/${q2maxdir}/sdlquake2

		insinto ${q2maxdir}/baseq2
		doins ${DISTDIR}/maxpak.pak
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Go read /usr/share/doc/${PF}/README-postinstall.gz right now!"
	einfo "It's important- This install is just the engine, you still need"
	einfo "the data paks. Go read."
}
