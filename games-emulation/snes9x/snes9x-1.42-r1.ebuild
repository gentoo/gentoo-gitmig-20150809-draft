# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/snes9x/snes9x-1.42-r1.ebuild,v 1.6 2004/11/11 01:31:42 josejx Exp $

inherit eutils games

DESCRIPTION="Super Nintendo Entertainment System (SNES) emulator"
HOMEPAGE="http://www.snes9x.com/"
SRC_URI="http://www.lysator.liu.se/snes9x/${PV}/snes9x-${PV}-src.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="3dfx opengl X joystick"

RDEPEND="sys-libs/zlib
	virtual/x11
	media-libs/libpng
	opengl? ( virtual/opengl )
	3dfx? ( media-libs/glide-v3 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	x86? ( dev-lang/nasm )"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd "${S}/snes9x"
	epatch "${FILESDIR}/${PV}-system-zlib.patch"
	epatch "${FILESDIR}/nojoy.patch"
}

src_compile() {
	local vidconf=
	local target=
	local vid=

	mkdir mybins
	for vid in 3dfx opengl X ; do
		use ${vid} || continue
		cd "${S}/snes9x"
		case ${vid} in
			3dfx)
				vidconf="--with-glide --without-opengl --without-x"
				target=gsnes9x;;
			opengl)
				vidconf="--with-opengl --without-glide --without-x"
				target=osnes9x;;
			X)
				vidconf="--with-x --without-glide --without-opengl"
				target=snes9x;;
		esac
		# this stuff is ugly but hey the build process sucks ;)
		OPTFLAGS="${CXXFLAGS} -DHAVE_LIBPNG" \
		egamesconf \
			--with-screenshot \
			$(use_with joystick) \
			${vidconf} \
			$(use_with x86 assembler) \
				|| die
		emake \
			EXTRALIBS="$(libpng-config --libs) -lpthread" \
			${target} || die "making ${target}"
		mv ${target} "${S}/mybins/"
		cd "${WORKDIR}"
		rm -rf "${S}/snes9x"
		src_unpack
	done
}

src_install() {
	dogamesbin mybins/* || die "dogamesbin failed"
	dodoc faqs.txt readme.txt readme.unix snes9x/*.txt
	prepgamesdirs
}
