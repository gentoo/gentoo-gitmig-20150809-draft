# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/snes9x/snes9x-1.43-r1.ebuild,v 1.10 2006/10/19 14:55:38 nyhm Exp $

# 3dfx support (glide) is disabled because it requires
# glide-v2 while we only provide glide-v3 in portage
# http://bugs.gentoo.org/show_bug.cgi?id=93097

inherit eutils flag-o-matic multilib games

DESCRIPTION="Super Nintendo Entertainment System (SNES) emulator"
HOMEPAGE="http://www.snes9x.com/"
SRC_URI="http://www.lysator.liu.se/snes9x/${PV}/snes9x-${PV}-src.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="opengl joystick zlib dga debug"

RDEPEND="|| ( ( x11-libs/libXext
				dga? ( x11-libs/libXxf86dga
					   x11-libs/libXxf86vm ) )
			  virtual/x11 )
	media-libs/libpng
	amd64? ( app-emulation/emul-linux-x86-xlibs )
	opengl? (
		virtual/opengl
		virtual/glu )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	|| ( ( x11-proto/xextproto
		   x11-proto/xproto
		   dga? ( x11-proto/xf86dgaproto
		   		  x11-proto/xf86vidmodeproto ) )
		 virtual/x11 )"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd "${S}"/snes9x
	rm offsets # stupid prebuilt file
	sed -i \
		-e 's:-lXext -lX11::' Makefile.in \
		|| die "sed failed"
	epatch \
		"${FILESDIR}"/nojoy.patch \
		"${FILESDIR}"/${P}-porting.patch \
		"${FILESDIR}"/${P}-key-bindings-fix.patch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-config.patch

	sed -i \
		-e 's:png_jmpbuf:png_write_info:g' \
		-e '/X_LDFLAGS=/d' \
		configure.in || die "sed failed"

	autoconf || die
}

src_compile() {
	[[ -z ${NATIVE_AMD64_BUILD_PLZ} ]] && use amd64 && multilib_toolchain_setup x86

	local vidconf=
	local target=
	local vid=

	append-ldflags -Wl,-z,noexecstack

	mkdir mybins
	for vid in opengl fallback ; do
		if [[ ${vid} != "fallback" ]] ; then
			use ${vid} || continue
		fi
		cd "${S}"/snes9x
		case ${vid} in
#			3dfx)
#				vidconf="--with-glide --without-opengl --without-x"
#				target=gsnes9x;;
			opengl)
				vidconf="--with-opengl --without-glide --without-x"
				target=osnes9x;;
			fallback)
				vidconf="--with-x --without-glide --without-opengl"
				target=snes9x;;
		esac
		# this stuff is ugly but hey the build process sucks ;)
		egamesconf \
			${vidconf} \
			$(use_with x86 assembler) \
			$(use_with joystick) \
			$(use_with debug debugger) \
			$(use_with zlib) \
			--with-screenshot \
			$(use_with dga extensions) \
			|| die
		# Makefile doesnt quite support parallel builds
		emake -j1 offsets || die "making offsets"
		emake ${target} || die "making ${target}"
		mv ${target} "${S}"/mybins/
		cd "${WORKDIR}"
		rm -r "${S}"/snes9x
		src_unpack
	done
}

src_install() {
	dogamesbin mybins/* || die "dogamesbin failed"
	dodoc faqs.txt readme.txt readme.unix snes9x/*.txt
	prepgamesdirs
}
