# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake2-icculus/quake2-icculus-0.15.ebuild,v 1.3 2003/12/30 04:01:17 mr_bones_ Exp $

inherit games eutils gcc

MY_P=quake2-r${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The icculus.org linux port of iD's quake2 engine"
HOMEPAGE="http://icculus.org/quake2/"
SRC_URI="http://icculus.org/quake2/files/${MY_P}.tar.gz
	!noqmax? ( http://icculus.org/quake2/files/maxpak.pak )
	rogue? ( ftp://ftp.idsoftware.com/idstuff/quake2/source/roguesrc320.shar.Z )
	xatrix? ( ftp://ftp.idsoftware.com/idstuff/quake2/source/xatrixsrc320.shar.Z )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="svga X sdl aalib opengl noqmax rogue xatrix"

# default to X11 if svga/X/sdl/aalib are not in USE
RDEPEND="svga? ( media-libs/svgalib )
	arts? ( kde-base/arts )
	X? ( virtual/x11 )
	sdl? ( media-libs/libsdl )
	aalib? ( media-libs/aalib )
	opengl? ( virtual/opengl )
	|| ( svga? ( "" ) X? ( "" ) sdl? ( "" ) aalib? ( "" ) virtual/x11 )"
DEPEND="${RDEPEND}
	app-arch/sharutils"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	[ `gcc-major-version` == 3 ] && epatch ${FILESDIR}/${PV}-Makefile-gcc3.patch
	epatch ${FILESDIR}/${PV}-Makefile-optflags.patch
	ln -s `which echo` ${T}/more
	for g in `use rogue` `use xatrix` ; do
		mkdir -p ${S}/src/${g}
		cd ${S}/src/${g}
		unpack ${g}src320.shar.Z
		sed -i 's:^read ans:ans=yes :' ${g}src320.shar
		env PATH="${T}:${PATH}" unshar ${g}src320.shar
		rm ${g}src320.shar
	done
	use rogue && sed -i 's:<nan\.h>:<bits/nan.h>:' ${S}/src/rogue/g_local.h
}

yesno() {
	for f in $@ ; do
		[ `use $f` ] || { echo NO ; return 1 ; }
	done
	echo YES
	return 0
}

src_compile() {
	BUILD_X11=`yesno X`
	use sdl || use X || use svga || use aalib || BUILD_X11=YES

	# xatrix fails to build
	# rogue fails to build
	for BUILD_QMAX in YES NO ; do
		[ `use noqmax` ] && [ "${BUILD_QMAX}" == "YES" ] && continue
		make clean || die "cleaning failed"
		make build_release \
			BUILD_SDLQUAKE2=`yesno sdl` \
			BUILD_SVGA=`yesno svga` \
			BUILD_X11=${BUILD_X11} \
			BUILD_GLX=`yesno opengl X` \
			BUILD_SDL=`yesno sdl` \
			BUILD_SDLGL=`yesno sdl opengl` \
			BUILD_CTFDLL=YES \
			BUILD_XATRIX=`yesno xatrix` \
			BUILD_ROGUE=`yesno rogue` \
			BUILD_JOYSTICK=`yesno joystick` \
			BUILD_DEDICATED=YES \
			BUILD_AA=`yesno aalib` \
			BUILD_QMAX=${BUILD_QMAX} \
			HAVE_IPV6=NO \
			BUILD_ARTS=NO \
			SDLDIR=/usr/lib \
			BUILD_ARTS=`yesno arts` \
			OPTCFLAGS="${CFLAGS}" \
			|| die "make failed"
			#HAVE_IPV6=`yesno ipv6` \
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
#	strip my-rel-NO/{*,*/*}

	into ${GAMES_PREFIX}
	newbin ${FILESDIR}/quake2.start quake2
	newbin ${FILESDIR}/q2ded.start q2ded
	if [ `use sdl` ] ; then
		newbin ${FILESDIR}/sdlquake2.start sdlquake2
		dosed "s:GENTOO_LIBDIR:${q2dir}:" ${GAMES_BINDIR}/sdlquake2
	fi
	dosed "s:GENTOO_LIBDIR:${q2dir}:" ${GAMES_BINDIR}/quake2
	dosed "s:GENTOO_LIBDIR:${q2dir}:" ${GAMES_BINDIR}/q2ded

	# q2max files
	if [ ! `use noqmax` ] ; then
		dodir ${q2maxdir}
		cp -rf my-rel-YES/* ${D}/${q2maxdir}/

		into ${GAMES_PREFIX}
		newbin ${FILESDIR}/quake2.start quake2-qmax
		newbin ${FILESDIR}/q2ded.start q2ded-qmax
		if [ `use sdl` ] ; then
			newbin ${FILESDIR}/sdlquake2.start sdlquake2-qmax
			dosed "s:GENTOO_LIBDIR:${q2maxdir}:" ${GAMES_BINDIR}/sdlquake2-qmax
		fi
		dosed "s:GENTOO_LIBDIR:${q2maxdir}:" ${GAMES_BINDIR}/quake2-qmax
		dosed "s:GENTOO_LIBDIR:${q2maxdir}:" ${GAMES_BINDIR}/q2ded-qmax

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
