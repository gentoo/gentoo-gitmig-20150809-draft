# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/armagetronad/armagetronad-0.2.8.1.ebuild,v 1.2 2006/04/30 19:55:30 genstef Exp $

inherit flag-o-matic eutils games

DESCRIPTION="\"A Tron clone in 3D\""
HOMEPAGE="http://armagetronad.net/"
SRC_URI="mirror://sourceforge/armagetronad/${P}.src.tar.bz2
	moviesounds? (
		http://armagetron.sourceforge.net/addons/moviesounds_fq.zip
		linguas_es? ( !linguas_en? (
			http://usuario.tiscalinet.es/hgctiscali/naflat/downloads/spanishvoices.zip
		) )
	)
	moviepack? (
		http://armagetron.sourceforge.net/addons/moviepack.zip
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug dedicated krawall opengl moviepack moviesounds"

GLDEPS="|| (
			virtual/x11
			x11-libs/libX11
		)
		virtual/glu
		virtual/opengl
		media-libs/libsdl
		media-libs/sdl-image
		media-libs/jpeg
		media-libs/libpng"
RDEPEND="
		>=dev-libs/libxml2-2.6.12
		sys-libs/zlib
		opengl? ( ${GLDEPS} )
		!dedicated? ( ${GLDEPS} )"
DEPEND="${RDEPEND}
	moviepack? ( app-arch/unzip )
	moviesounds? ( app-arch/unzip )
	linguas_es? ( !linguas_en? ( app-arch/unzip ) )"

pkg_setup() {
	if use debug; then
		ewarn
		ewarn 'The "debug" USE flag will enable debugging code. This will cause AI'
		ewarn ' players to chat debugging information, debugging lines to be drawn'
		ewarn ' on the grid and at wall angles, and probably most relevant to your'
		ewarn ' decision to keep the USE flag:'
		ewarn '         FULL SCREEN MODE AND SOUND WILL BE DISABLED'
		ewarn
		ewarn "If you don't like this, add this line to /etc/portage/package.use:"
		ewarn '	games-action/armagetronad -debug'
		ewarn
		ewarn 'If you ignore this warning and complain about any of the above'
		ewarn ' effects, the Armagetron Advanced team will either ignore you or'
		ewarn ' delete your complaint.'
		ewarn
		ebeep 5
	fi
	# Assume client if they don't want a server
	use opengl || ! use dedicated && build_client=true || build_client=false
	use dedicated && build_server=true || build_server=false

	MyEMAKE="armabindir=${GAMES_BINDIR}"	# we have a broken build system, I guess
	# Note: Music isn't there yet
	COMMON_CONFIG="--disable-master --enable-main --disable-memmanager --disable-music $(use_enable krawall) --enable-sysinstall --disable-useradd --enable-etc --disable-restoreold --disable-games"
	if [ "$SLOT" == "0" ]; then
		COMMON_CONFIG="${COMMON_CONFIG} --disable-multiver"
		GameSLOT=""
	else
		COMMON_CONFIG="${COMMON_CONFIG}  --enable-multiver=${SLOT}"
		GameSLOT="-${SLOT}"
	fi
	UNINSTALL_CONFIG=--enable-uninstall="emerge --clean =${CATEGORY}/${PF}"
	if use debug; then
		DEBUGLEVEL=3
	else
		DEBUGLEVEL=0
	fi
	CODELEVEL=0
}

src_unpack() {
	unpack ${A}
	cd "${S}/batch"
	epatch "${FILESDIR}/0280_fix-sysinstall.patch"
}

aabuild() {
	MyBUILDDIR="${WORKDIR}/build-$1"
	mkdir -p "${MyBUILDDIR}" || die "error creating build directory($1)"	# -p to allow EEXIST scenario
	cd "${MyBUILDDIR}"
	cat >configure <<EOF
#!/bin/sh
"${S}/configure" "\$@"
EOF
	chmod +x configure
	export DEBUGLEVEL CODELEVEL
	egamesconf ${COMMON_CONFIG} "${UNINSTALL_CONFIG}" "${@:2}" || die "egamesconf($1) failed"
	if [ "$1" == "server" ]; then
		ded='-dedicated'
	else
		ded=''
	fi
	cat >>"config.h" <<EOF
#undef ENABLE_BINRELOC
#define DATA_DIR "${GAMES_DATADIR}/${PN}${ded}${GameSLOT}"
#define CONFIG_DIR "${GAMES_SYSCONFDIR}/${PN}${ded}${GameSLOT}"
#define RESOURCE_DIR "${GAMES_DATADIR}/${PN}${ded}${GameSLOT}/resource"
#define USER_DATA_DIR "~/.${PN}"
#define AUTORESOURCE_DIR "~/.${PN}/resource/automatic"
#define INCLUDEDRESOURCE_DIR "${GAMES_DATADIR}/${PN}${ded}${GameSLOT}/resource/included"
EOF
	emake ${MyEMAKE} || die "emake($1) failed"
}

src_compile() {
	filter-flags -fno-exceptions
	if ${build_client}; then
		einfo "Building game client"
		aabuild client  --enable-glout --disable-initscripts  --enable-desktop
	fi
	if ${build_server}; then
		einfo "Building dedicated server"
		aabuild server --disable-glout  --enable-initscripts --disable-desktop
	fi
}

src_install() {
	if ${build_client} && ${build_server}; then
		# Setup symlink so both client and server share their common data
		mkdir -p "${D}${GAMES_DATADIR}"
		dosym "${PN}${GameSLOT}" "${GAMES_DATADIR}/${PN}-dedicated${GameSLOT}"
	fi
	if ${build_client}; then
		einfo "Installing game client"
		cd "${WORKDIR}/build-client"
		emake install DESTDIR="${D}" ${MyEMAKE} || die "emake(client) install failed"
		# copy moviepacks/sounds
		cd "${WORKDIR}"
		insinto "${GAMES_DATADIR}/${PN}${GameSLOT}"
		if use moviepack; then
			einfo 'Installing moviepack'
			doins -r moviepack || die "copying moviepack"
		fi
		if use moviesounds; then
			einfo 'Installing moviesounds'
			doins -r moviesounds || die "copying moviesounds"
			if use linguas_es && ! use linguas_en; then
				einfo 'Installing Spanish moviesounds'
				doins -r ArmageTRON/moviesounds || die "copying spanish moviesounds"
			fi
		fi
	fi
	if ${build_server}; then
		einfo "Installing dedicated server"
		cd "${WORKDIR}/build-server"
		emake install DESTDIR="${D}" ${MyEMAKE} || die "emake(server) install failed"
		einfo 'Adjusting dedicated server configuration'
		sed -i "s,\(^user=\).*$,\1${GAMES_USER_DED},; s,^#VARDIR=\$HOME/./armagetronad-dedicated$,\\0\\nVARDIR=${GAMES_STATEDIR}/${PN}-dedicated${GameSLOT}," "${D}${GAMES_SYSCONFDIR}/${PN}-dedicated${GameSLOT}/rc.config"
		DedHOME="$(eval echo ~${GAMES_USER_DED})"
		mkdir -p "${D}${DedHOME}"
		dosym "${GAMES_STATEDIR}/${PN}-dedicated${GameSLOT}" "${DedHOME}/.${PN}"
	fi
	# Ok, so we screwed up on doc installation... so for now, the ebuild does this manually
	dohtml -r "${D}${GAMES_PREFIX}/share/doc/${PN}${ded}${GameSLOT}/html/"*
	dodoc "${D}${GAMES_PREFIX}/share/doc/${PN}${ded}${GameSLOT}/html/"*.txt
	rm -r "${D}${GAMES_PREFIX}/share/doc"
	rmdir "${D}${GAMES_PREFIX}/share" || true	# Supress potential error
	prepgamesdirs
}
