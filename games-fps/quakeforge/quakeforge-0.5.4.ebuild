# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quakeforge/quakeforge-0.5.4.ebuild,v 1.8 2004/02/20 06:35:23 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A new 3d engine based off of id Softwares's legendary Quake and QuakeWorld game engine"
HOMEPAGE="http://www.quakeforge.org/"
SRC_URI="mirror://sourceforge/quake/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="debug 3dfx fbcon opengl sdl svga X ncurses oggvorbis zlib ipv6 xv dga xmms alsa oss"
RESTRICT="nouserpriv"

RDEPEND="!amd64? ( 3dfx? ( media-libs/glide-v3 ) )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl )
	svga? ( media-libs/svgalib )
	X? ( virtual/x11 )
	ncurses? ( sys-libs/ncurses )
	oggvorbis? ( media-libs/libogg media-libs/libvorbis )
	zlib? ( sys-libs/zlib )
	xv? ( virtual/x11 )
	dga? ( virtual/x11 )
	xmms? ( media-sound/xmms )
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-com-parse.patch
	epatch ${FILESDIR}/${PV}-alsa.patch
#	sed -i \
#		-e 's:heavy=.*:heavy=:' \
#		-e 's:light=.*:light=:' \
#		-e 's:MORE_CFLAGS=".*":MORE_CFLAGS="":' \
#		configure || die "removing static cflags from configure"
}

src_compile() {
	#i should do this at some point :x ... i guess if you disable all shared stuff
	#and enable all the static options explicitly, static works ... (or so ive been told)
	#if [ -z "`use static`" ] ; then
	#	myconf="${myconf} --enable-shared=yes --enable-static=no"
	#else
	#	myconf="${myconf} --enable-shared=no --enable-static=yes"
	#fi

	local debugopts
	[ `use debug` ] \
		&& debugopts="--enable-debug --disable-optimize --enable-profile" \
		|| debugopts="--disable-debug --disable-profile"

	local clients=${QF_CLIENTS}
	[ `use 3dfx` ] && clients="${clients},3dfx"
	[ `use fbcon` ] && clients="${clients},fbdev"
	[ `use opengl` ] && clients="${clients},glx"
	[ `use sdl` ] && clients="${clients},sdl,sdl32"
	[ `use svga` ] && clients="${clients},svga"
	[ `use X` ] && clients="${clients},x11"
	[ `use X` ] && [ `use opengl` ] && clients="${clients},wgl"
	[ "${clients:0:1}" == "," ] && clients=${clients:1}

	local servers=${QF_SERVERS:-master,nq,qw}

	local tools=${QF_TOOLS:-all}

	local svgaconf	# use old school way for broken conf opts
	[ `use svga` ] \
		&& svgaconf="--with-svga=/usr" \
		|| svgaconf="--without-svga"

	addpredict ${GAMES_LIBDIR}
	egamesconf \
		`use_enable ncurses curses` \
		`use_enable oggvorbis vorbis` \
		`use_enable zlib` \
		`use_with ipv6` \
		`use_with fbcon fbdev` \
		${svgaconf} \
		`use_with X x` \
		`use_enable xv vidmode` \
		`use_enable dga` \
		`use_enable sdl` \
		`use_enable xmms` \
		`use_enable alsa` \
		`use_enable oss` \
		--enable-sound \
		--disable-optimize \
		${debugopts} \
		--with-global-cfg=${GAMES_SYSCONFDIR}/quakeforge.conf \
		--with-sharepath=${GAMES_DATADIR}/quake-data \
		--with-clients=${clients} \
		--with-servers=${servers} \
		--with-tools=${tools} \
		|| die
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	mv ${D}/${GAMES_PREFIX}/include ${D}/usr/
	dodoc ChangeLog INSTALL NEWS TODO doc/*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Before you can play, you must make sure"
	einfo "QuakeForge can find your Quake .pak files"
	echo
	einfo "You have 2 choices to do this"
	einfo "1 Copy pak*.pak files to ${GAMES_DATADIR}/quake-data/id1"
	einfo "2 Symlink pak*.pak files in ${GAMES_DATADIR}/quake-data/id1"
	echo
	einfo "Example:"
	einfo "my pak*.pak files are in /mnt/secondary/Games/Quake/Id1/"
	einfo "ln -s /mnt/secondary/Games/Quake/Id1/pak0.pak ${GAMES_DATADIR}/quake-data/id1/pak0.pak"
	echo
	einfo "You only need pak0.pak to play the demo version,"
	einfo "the others are needed for registered version"
}
