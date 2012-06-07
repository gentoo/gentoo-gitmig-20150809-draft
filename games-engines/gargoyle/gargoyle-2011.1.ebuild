# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/gargoyle/gargoyle-2011.1.ebuild,v 1.2 2012/06/07 05:51:28 vapier Exp $

# Regarding licenses: libgarglk is licensed under the GPLv2. Bundled
# interpreters are licensed under GPLv2, BSD or MIT license, except:
#   - glulxe: custom license, see "terps/glulxle/README"
#   - hugo: custom license, see "licenses/HUGO License.txt"
# Since we don't compile or install any of the bundled fonts, their licenses
# don't apply. (Fonts are installed through dependencies instead.)

EAPI=3

inherit eutils games multiprocessing

DESCRIPTION="An Interactive Fiction (IF) player supporting all major formats"
HOMEPAGE="http://ccxvii.net/gargoyle/"
SRC_URI="http://garglk.googlecode.com/files/${P}-sources.zip"

LICENSE="BSD GPL-2 MIT Hugo Glulxe"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/freetype:2
	virtual/jpeg
	media-libs/libpng
	media-fonts/liberation-fonts
	>=media-fonts/libertine-ttf-5
	sys-libs/zlib
	x11-libs/gtk+:2
	media-libs/sdl-mixer
	media-libs/sdl-sound[modplug,mp3,vorbis]"

DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/ftjam"

src_prepare() {
	# Substitute custom CFLAGS/LDFLAGS.
	sed -i -e \
		"/^\s*OPTIM = / {
			s/ \(-O.*\)\? ;/ ${CFLAGS} ;/
			a LINKFLAGS = ${LDFLAGS} ;
			a SHRLINKFLAGS = ${LDFLAGS} ;
		}" Jamrules || die

	# Don't link against libraries used indirectly through SDL_sound.
	sed -i -e "/GARGLKLIBS/s/-lsmpeg -lvorbisfile//g" Jamrules

	# Convert garglk.ini to UNIX format.
	edos2unix garglk/garglk.ini

	# The font name of Linux Libertine changed in version 5.
	sed -i -e 's/Linux Libertine O/Linux Libertine/g' garglk/garglk.ini
}

src_compile() {
	jam \
		-sGARGLKINI="${GAMES_SYSCONFDIR}/garglk.ini" \
		-sUSESDL=yes \
		-sBUNDLEFONTS=no \
		-j$(makeopts_jobs) || die
}

src_install() {
	DESTDIR="${D}" \
	_BINDIR="${GAMES_PREFIX}/libexec/${PN}" \
	_APPDIR="${GAMES_PREFIX}/libexec/${PN}" \
	_LIBDIR="$(games_get_libdir)" \
	EXEMODE=755 \
	FILEMODE=755 \
	jam install || die

	# Install config file.
	insinto "${GAMES_SYSCONFDIR}"
	newins garglk/garglk.ini garglk.ini || die

	# Install application entry and icon.
	insinto /usr/share/applications
	doins garglk/${PN}.desktop || die
	doicon garglk/${PN}-house.png || die

	# Symlink binaries to avoid name clashes.
	for terp in advsys agility alan2 alan3 frotz geas git glulxe hugo jacl \
		level9 magnetic nitfol scare tadsr
	do
		dosym "${GAMES_PREFIX}/libexec/${PN}/${terp}" \
			"${GAMES_BINDIR}/${PN}-${terp}" || die
	done

	# Also symlink the main binary since it resides in libexec.
	dosym "${GAMES_PREFIX}/libexec/${PN}/${PN}" \
		"${GAMES_BINDIR}/${PN}" || die

	prepgamesdirs
}
