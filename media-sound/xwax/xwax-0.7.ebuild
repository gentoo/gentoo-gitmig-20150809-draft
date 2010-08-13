# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xwax/xwax-0.7.ebuild,v 1.5 2010/08/13 13:37:50 josejx Exp $

EAPI=3
inherit toolchain-funcs

DESCRIPTION="Digital vinyl emulation software"
HOMEPAGE="http://www.xwax.co.uk/"
SRC_URI="http://www.xwax.co.uk/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
# These make sure the user can decode the files he or she cares about by
# setting appropriate runtime depends and (perhaps) configuring the import
# script
IUSE_XWAX_DECODERS="xwax_decoders_aac xwax_decoders_cd xwax_decoders_flac \
	+xwax_decoders_mp3 xwax_decoders_ogg xwax_decoders_misc"
IUSE="alsa jack ${IUSE_XWAX_DECODERS}"

RDEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-fonts/dejavu
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	xwax_decoders_aac? ( media-libs/faad2 )
	xwax_decoders_cd? ( media-sound/cdparanoia )
	xwax_decoders_flac? ( media-libs/flac )
	xwax_decoders_mp3? ( || ( media-sound/mpg123 media-sound/mpg321 ) )
	xwax_decoders_ogg? ( media-sound/vorbis-tools )
	xwax_decoders_misc? ( media-video/ffmpeg )"
DEPEND="${RDEPEND}"

DOCS="README CHANGES"

src_prepare() {
	# Remove the forced optimization from 'CFLAGS' and 'LDFLAGS' in
	# the Makefile
	sed -i -e 's:\(^CFLAGS.*\)-O[0-9]\(.*\):\1\2:' \
		-e 's:\(^LDFLAGS.*\)-O[0-9]\(.*\):\1\2:' \
		Makefile || die "sed failed"
}

src_configure() {
	tc-export CC
	econf \
		$(use_enable alsa) \
		$(use_enable jack)
}

src_compile() {
	# EXECDIR is the default directory in which xwax will look for
	# the 'xwax-import' and 'xwax-scan' scripts
	emake PREFIX="${EROOT}usr" EXECDIR="${EROOT}usr/bin"
}

src_install() {
	# This is easier than setting all the environment variables
	# needed, running the sed script required to get the man directory
	# correct, and removing the GPL-2 after a 'make install' run
	dobin xwax || die "failed to install xwax"
	newbin import xwax-import || die "failed to install xwax-import"
	newbin scan xwax-scan || die "failed to install xwax-scan"
	doman xwax.1 || die "failed to install man page"

	# Replace any decoder commands in the import script, if necessary
	if use xwax_decoders_mp3; then
		# mpg123 is upstream's default
		if has_version media-sound/mpg123; then
			debug-print "found mpg123"
			dosed "s:mpg321:mpg123:g" /usr/bin/xwax-import || \
				die "problem converting xwax-import to use mpg123"
		# Otherwise, use mpg321
		else
			debug-print "found mpg321"
			dosed "s:mpg123:mpg321:g" /usr/bin/xwax-import || \
				die "problem converting xwax-import to use mpg321"
		fi
	fi

	dodoc ${DOCS} || die "failed to install docs"
}
