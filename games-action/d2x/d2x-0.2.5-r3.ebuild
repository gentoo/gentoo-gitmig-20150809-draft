# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/d2x/d2x-0.2.5-r3.ebuild,v 1.6 2007/09/06 22:32:18 wolf31o2 Exp $

inherit eutils flag-o-matic games

DESCRIPTION="Descent 2 engine from Icculus"
HOMEPAGE="http://icculus.org/d2x/"
SRC_URI="http://icculus.org/d2x/src/${P}.tar.gz"

LICENSE="D1X"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cdinstall debug opengl ggi svga"

COMMON="media-libs/libsdl
	media-libs/sdl-image
	opengl? ( virtual/opengl )
	ggi? ( media-libs/libggi )
	svga? ( media-libs/svgalib )"
RDEPEND="${COMMON}
	cdinstall? ( games-action/descent2-data )
	!cdinstall? ( games-action/descent2-demodata )"
DEPEND="${COMMON}
	x86? ( dev-lang/nasm )"

dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}-shellscripts.patch"
	epatch "${FILESDIR}/${P}-dofpcalcs-macro.patch"

	sed -i \
		-e '/NASMFLAGS/s/-d/-D/g' \
		configure \
		2d/Makefile.in \
		|| die "sed failed"
	sed -i \
		-e 's/@@/l@@/' \
		2d/tmerge_a.asm \
		|| die "sed failed"
}

src_compile() {
	local defflags myconf ren renconf

	# --disable-network --enable-console
	local myconf="$(use_enable x86 assembler)"
	use debug \
		&& myconf="${myconf} --enable-debug --disable-release" \
		|| myconf="${myconf} --disable-debug --enable-release"
	# we do this because each of the optional guys define the same functions
	# in gr, thus when they go to link they cause redefine errors ...
	# we build each by it self, save the binary file, clean up, and start over
	mkdir my-bins
	for ren in sdl $(useq opengl && echo opengl) \
			$(useq svga && echo svga) $(useq ggi && echo ggi) ; do
		[[ "${ren}" == "sdl" ]] \
			&& renconf="" \
			|| renconf="--with-${ren}"
		[[ "${ren}" == "svga" ]] \
			&& defflags="-DSVGALIB_INPUT" \
			|| defflags=""
		make distclean
		egamesconf \
			${myconf} \
			${renconf} \
			--datadir="${GAMES_DATADIR_BASE}" \
			|| die "conf ${ren}"
		emake CXXFLAGS="${CXXFLAGS} ${defflags}" || die "build ${ren}"
		mv d2x* my-bins/
	done
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dogamesbin my-bins/* || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog NEWS README* TODO readme.txt

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "d2x-rebirth is a more up-to-date version of this game."
	echo
}
