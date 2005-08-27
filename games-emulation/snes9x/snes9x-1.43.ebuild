# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/snes9x/snes9x-1.43.ebuild,v 1.6 2005/08/27 04:25:46 vapier Exp $

# 3dfx support (glide) is disabled because it requires
# glide-v2 while we only provide glide-v3 in portage
# http://bugs.gentoo.org/show_bug.cgi?id=93097

inherit eutils games flag-o-matic

DESCRIPTION="Super Nintendo Entertainment System (SNES) emulator"
HOMEPAGE="http://www.snes9x.com/"
SRC_URI="http://www.lysator.liu.se/snes9x/${PV}/snes9x-${PV}-src.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="opengl X joystick zlib dga debug"

RDEPEND="zlib? ( sys-libs/zlib )
	virtual/x11
	media-libs/libpng
	amd64? ( emul-linux-x86-xlibs )
	opengl? ( virtual/opengl virtual/glu )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd "${S}"/snes9x
	epatch "${FILESDIR}"/nojoy.patch
	sed -i 's:png_jmpbuf:png_write_info:g' configure

	rm offsets # stupid prebuilt file
	sed -i -e 's:-lXext -lX11::' Makefile.in
	sed -i -e '/X_LDFLAGS=/d' configure
	cp Makefile.in{,.orig}
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	if use amd64 ; then
		export ABI=x86
		append-flags -m32
		append-ldflags -m32
	fi

	local vidconf=
	local target=
	local vid=

	mkdir mybins
	for vid in opengl X fallback ; do
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
			fallback|X)
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
